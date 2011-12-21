Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RdHW4-0000sN-KE
 for kexec@lists.infradead.org; Wed, 21 Dec 2011 08:27:14 +0000
Date: Wed, 21 Dec 2011 17:22:30 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 10/14] Generate and save VMCOREINFO and ELF note
 information
Message-Id: <20111221172230.7c4bda3c.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20111220.183158.52163975.d.hatayama@jp.fujitsu.com>
References: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
 <20111028094858.20940.24950.stgit@localhost6.localdomain6>
 <20111220171812.874961f9.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20111220.183158.52163975.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hi Hatayama-san,

> > I have a question.
> > In what kind of case is only one of the offset or the size set to 0 in PT_NOTE?
> > 
> 
> Thanks for your reviewing.
> 
> On sadump processing, offset_pt_note_memory represents file offset to
> a temporary file created specifically for writing PT_NOTE section. So
> offset_pt_note_memory is always 0. Its file pointer is set to struct
> sadump_info::file_elf_note. Please look at the end of
> sadump_generate_elf_note_from_dumpfile().
> 
> On the other hand, on both ELF and kdump-compressed format, PT_NOTE
> section is always located in the middle of the vmcores. On either
> formats, there's always another header before the PT_NOTE section: on
> ELF, ELF header, and on kdump-compressed format, at least. So
> offset_pt_note_memory is always strictly greater than 0 on these
> formats.
> 
> If condition of has_pt_note() is not weakened in such a way,
> has_pt_note() amounts to always false and execution in
> write_kdump_header() always passes through writing oepration for
> PT_NOTE section.


Thank you for your explanation. I understand.
However
	if (offset_pt_note_memory || size_pt_note_memory)
seems to allow the offset != 0 and the size == 0.
Is the following fixing right?
I would like to fix has_pt_note() like this.
How about this?

-	if (offset_pt_note_memory && size_pt_note_memory)
+       if (info->flag_sadump) {
+		if (size_pt_note_memory)
+			return TRUE;
+	} else if (offset_pt_note_memory && size_pt_note_memory)
			return TRUE;

Thanks.
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
