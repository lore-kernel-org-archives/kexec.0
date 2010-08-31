Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OqLIj-0006yl-V1
	for kexec@lists.infradead.org; Tue, 31 Aug 2010 07:30:39 +0000
Date: Tue, 31 Aug 2010 16:28:50 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: makedumpfile failed for 2.6.36-rc2
Message-Id: <20100831162850.855f034a.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <293574147.1621571283237402253.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <839326586.1621551283237394919.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<293574147.1621571283237402253.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Tue__31_Aug_2010_16_28_50_+0900_Uv2vmayBevbHND4M"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: caiqian@redhat.com
Cc: kexec <kexec@lists.infradead.org>

This is a multi-part message in MIME format.

--Multipart=_Tue__31_Aug_2010_16_28_50_+0900_Uv2vmayBevbHND4M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Cai,

On Tue, 31 Aug 2010 02:50:02 -0400 (EDT)
caiqian@redhat.com wrote:
> > Thank you for the report.
> > 
> > I'd like to reproduce the same problem on my machine,
> > could you please send your kernel .config file ?
>
> Attached.

Thank you.
The linux-2.6.36-rc2 kernel is building now with your .config file.
After building, I will test makedumpfile on the kernel.


>> readmem: Can't seek the dump memory(/proc/vmcore). Invalid argument

lseek(2) failed with "Invalid argument", so the problem may be due to an
invalid offset. I'd like to know its value, so can you try the attached
patch in the condition makedumpfile fails ?
And can you send the output of `readelf -a /proc/vmcore` ?


Thanks
Ken'ichi Ohmichi

--Multipart=_Tue__31_Aug_2010_16_28_50_+0900_Uv2vmayBevbHND4M
Content-Type: application/octet-stream;
 name="print_offset_if_lseek_error.patch"
Content-Disposition: attachment;
 filename="print_offset_if_lseek_error.patch"
Content-Transfer-Encoding: base64

LS0tIGEvbWFrZWR1bXBmaWxlLmMJMjAxMC0wOC0zMSAxNjo0NTo1NS4wMDAwMDAwMDAgKzA5MDAK
KysrIGIvbWFrZWR1bXBmaWxlLmMJMjAxMC0wOC0zMSAxNjo0NzoyMy4wMDAwMDAwMDAgKzA5MDAK
QEAgLTQ3Nyw4ICs0NzcsOCBAQAogCX0KIAogCWlmIChsc2VlayhpbmZvLT5mZF9tZW1vcnksIG9m
ZnNldCwgU0VFS19TRVQpID09IGZhaWxlZCkgewotCQlFUlJNU0coIkNhbid0IHNlZWsgdGhlIGR1
bXAgbWVtb3J5KCVzKS4gJXNcbiIsCi0JCSAgICBpbmZvLT5uYW1lX21lbW9yeSwgc3RyZXJyb3Io
ZXJybm8pKTsKKwkJRVJSTVNHKCJDYW4ndCBzZWVrIHRoZSBkdW1wIG1lbW9yeSglcykuIChvZmZz
ZXQ6ICVseCkgJXNcbiIsCisJCSAgICBpbmZvLT5uYW1lX21lbW9yeSwgb2Zmc2V0LCBzdHJlcnJv
cihlcnJubykpOwogCQlnb3RvIGVycm9yOwogCX0KIAo=

--Multipart=_Tue__31_Aug_2010_16_28_50_+0900_Uv2vmayBevbHND4M
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--Multipart=_Tue__31_Aug_2010_16_28_50_+0900_Uv2vmayBevbHND4M--

