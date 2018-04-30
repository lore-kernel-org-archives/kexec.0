Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fDF7s-0008JO-Fe
 for kexec@lists.infradead.org; Mon, 30 Apr 2018 20:10:22 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <cover.1525082669.git.rahul.lakkireddy@chelsio.com>
Date: Mon, 30 Apr 2018 15:09:30 -0500
In-Reply-To: <cover.1525082669.git.rahul.lakkireddy@chelsio.com> (Rahul
 Lakkireddy's message of "Mon, 30 Apr 2018 15:43:57 +0530")
Message-ID: <87h8ns4ft1.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 0/3] kernel: add support to collect hardware
 logs in crash recovery kernel
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

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> v6:
> - Reworked device dump elf note name to contain vendor identifier.
> - Added vmcoredd_header that precedes actual dump in the Elf Note.
> - Device dump's name is moved inside vmcoredd_header.
> - Added "CHELSIO" string as vendor identifier in the Elf Note name
>   for cxgb4 device dumps.

Yep you did and that is not correct.  My apologies if I was unclear.

An elf note looks like this:

/* Note header in a PT_NOTE section */
typedef struct elf32_note {
  Elf32_Word	n_namesz;	/* Name size */
  Elf32_Word	n_descsz;	/* Content size */
  Elf32_Word	n_type;		/* Content type */
} Elf32_Nhdr;

n_descsz is is the length of the body.

n_namesz is the length of the ``vendor'' but not the vendor of the your
driver.  It is the ``vendor'' that defines n_type.  So "LINUX" in our
case.

The pair "LINUX", NT_VMCOREDD go together.  That pair is what a
subsequent program must look at to decide how to understand the note.

Please don't use CRASH_CORE_NOTE_HEAD BYTES that obscures things
unnecessarily, and really is not applicable to this use case.
ALIGN(sizeof(struct elf_note), 4) is almost as short and it makes
it clear what your are talking about.


Also please don't look too closely as the other note stuff for Elf core
dumps.  That stuff was not well done from an Elf standards and ABI
perspective.  Unfortunately by the time I had noticed it was years later
so not something that is worth the breakage in tools to change now.

Looking at struct vmcoredd_header.

That seems a reasonable structure.  However it is a uapi structure so
we need to carefully definite it that way.

Perhaps:

#define VMCOREDD_MAX_NAME_BYTES  32

struct vmcoredd_header {
	__u32 header_len;	/* Length of this header */
        __u32 reserved;
        __u64 data_len;		/* Length of this device dump */
        __u8 dump_name[VMCOREDD_MAX_NAME_BYTES];
        __u8 reserved2[16];
};


Looking at that I see another siginficant issue.  We can't let the
device dump be more than 32bits long.  The length of an elf
note is defined by an elf word which is universally a __u32.

So perhaps vmcoredd_header should look like:

#define VMCOREDD_MAX_NAME_BYTES  44

struct vmcoredd_header {
	__u32	n_namesz;	/* Name size */
        __u32	n_descsz;	/* Content size */
        __u32	n_type;		/* NT_VMDOREDD */
	__u8	name[8];	/* LINUX\0\0\0 */
        __u8	dump_name[VMCOREDD_MAX_NAME_BYTES];
};

The total length of the data dump would be descsz - sizeof(struct
vmcoredd_header).  The header winds up being a constant 64 bytes this
way, and includes the elf note header.

Eric











_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
