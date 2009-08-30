Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MhdJn-00014i-SE
	for kexec@lists.infradead.org; Sun, 30 Aug 2009 05:51:16 +0000
Received: by ywh36 with SMTP id 36so4226040ywh.31
	for <kexec@lists.infradead.org>; Sat, 29 Aug 2009 22:51:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090827163319.GA3223@in.ibm.com>
References: <e997b7420908270854v423b51f9vc7e2d012c91360f@mail.gmail.com>
	<20090827163319.GA3223@in.ibm.com>
Date: Sun, 30 Aug 2009 13:51:09 +0800
Message-ID: <e997b7420908292251v19072667h8ac7c40a2739769b@mail.gmail.com>
Subject: Re: Does kexec support SMP on powerpc? E500 V2
From: "wilbur.chan" <wilbur512@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: mohan@in.ibm.com
Cc: kexec@lists.infradead.org

2009/8/28 M. Mohan Kumar <mohan@in.ibm.com>:

>
> Wilbur, I am not sure about ppc32 arch. Check
> kexec/purgatory/arch/ppc64/v2wrap.S which makes all secondary cpus to spin
> in a loop at the physical address 0x60
>
> Regards,
> M. Mohan Kumar
>

 I've read the code of kexec-elf-ppc64.c and v2wrap.S,

but got quit confused .


Hmmm...  as matter of fact, I'm not quit familliar with the principle
of  purgatory , because I

modified the standard kexec-tool that , I only passed in the kernel
segment , without any

ramdisk or other segments.


My questions are as followed:




q1:  const unsigned char purgatory[] =...  (kexec/purgatory.c)


 where are the  elements in Array 'purgatory'  coming from ?

Is it the binary form of  v2wrap.S ?





 (kexec_elf_ppc64.c)

q2:   elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,\
purgatory_size, 0, max_addr, 1, 0);

Does  the 'purgatory' here stand for the array above or v2wrap.S ?  or both?

What is this code used for?

q3:   elf_rel_get_symbol(&info->rhdr, "purgatory_start", slave_code,
			sizeof(slave_code));
   master_entry = slave_code[0];

 Does  master_entry euqal to the address of instruction 'b  master' in
v2wrap.S ?


q4:  memcpy(slave_code, info->segment[0].buf, sizeof(slave_code));

why coying 256 bytes  of kernel data to  slave_code ,  modify first 4 bytes

to  master_entry,then copy back to info->rhdr ?

Why doing this?



I saw comment saying :

'a copy of the first 0x100 bytes of this code(v2wrap.S)   is copied to
0, and , The above 0x100

bytes at purgatory_start are replaced with the  code from the kernel'

After this,  how the slave cpus jumps to 'slave' point in v2wrap.S  ,
while  master cpu jumps to

'purgatory_start' ?


Thank you



regards,

wilbur

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
