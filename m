Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fBsEn-0004Yu-2U
 for kexec@lists.infradead.org; Fri, 27 Apr 2018 01:31:51 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <cover.1524329561.git.rahul.lakkireddy@chelsio.com>
 <cover.1524329561.git.rahul.lakkireddy@chelsio.com>
 <1393d2fce1a2c2a0f78431845deae26bc28c16ef.1524329561.git.rahul.lakkireddy@chelsio.com>
Date: Thu, 26 Apr 2018 20:30:58 -0500
In-Reply-To: <1393d2fce1a2c2a0f78431845deae26bc28c16ef.1524329561.git.rahul.lakkireddy@chelsio.com>
 (Rahul Lakkireddy's message of "Sat, 21 Apr 2018 22:35:53 +0530")
Message-ID: <871sf1a10t.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 1/3] vmcore: add API to collect hardware dump
 in second kernel
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, davem@davemloft.net, ganeshgr@chelsio.com


While looking this over I found a bug in the way elf notes are being composed.

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index a45f0af22a60..7395462d2f86 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1145,6 +1150,132 @@ static int __init parse_crash_elf_headers(void)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
> +/**
> + * vmcoredd_get_note_size - Get size of the note that will be inserted at
> + * beginning of the dump's buffer.
> + * @name: Note's name
> + *
> + * Gets the overall size of the note that will be inserted at the beginning
> + * of the dump's buffer.  It also adds padding, if necessary to meet
> + * alignment requirements.
> + */
> +static inline size_t vmcoredd_get_note_size(const char *name)
> +{
> +	return CRASH_CORE_NOTE_HEAD_BYTES +
> +	       ALIGN(VMCOREDD_NOTE_NAME_BYTES + strlen(name), sizeof(Elf_Word));
> +}
> +
> +/**
> + * vmcoredd_write_note - Write note at the beginning of the dump's buffer
> + * @name: Dump's name
> + * @buf: Output buffer where the note is written
> + * @size: Size of the dump
> + *
> + * Fills beginning of the dump's data with elf note.
> + */
> +static void vmcoredd_write_note(const char *name, void *buf, size_t size)
> +{
> +	struct elf_note *note = (struct elf_note *)buf;
> +	Elf_Word *word = (Elf_Word *)note;
> +
> +	note->n_namesz = ALIGN(VMCOREDD_NOTE_NAME_BYTES + strlen(name),
> +			       sizeof(Elf_Word));
> +	note->n_descsz = size;
> +	note->n_type = NT_VMCOREDD;
> +	word += DIV_ROUND_UP(sizeof(*note), sizeof(Elf_Word));
> +	snprintf((char *)word, note->n_namesz, "%s_%s", VMCOREDD_NOTE_NAME,
> +		 name);

I hate to do this to you but as this is ABI I am going to pick on
this bit of code.

First namesz needs to include the '\0' of the name string.
Second you did not count the length of "_" namesz.
Third name needs to be a vendor identifier.  So "LINUX\0\0\0" in our case.

Which means the device name needs to be in the body of the note.
Perhaps just reserve 32 bytes for the device name?
Perhaps prefix the device name with a length?

The exact layout is whatever you want NT_VMCOREDD to mean.

> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index e2535d6dcec7..4e12c423b9fe 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -421,6 +421,7 @@ typedef struct elf64_shdr {
>  #define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
>  #define NT_ARM_SVE	0x405		/* ARM Scalable Vector Extension registers */
>  #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
> +#define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
>  
>  /* Note header in a PT_NOTE section */
>  typedef struct elf32_note {


Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
