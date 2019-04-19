Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hHRwR-0003SM-Pp
 for kexec@lists.infradead.org; Fri, 19 Apr 2019 11:44:29 +0000
Date: Fri, 19 Apr 2019 19:44:21 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190419114421.GH11060@MiWiFi-R3L-srv>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
 <20190419112801.GB10324@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190419112801.GB10324@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Kairui Song <kasong@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Junichi Nomura <j-nomura@ce.jp.nec.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

On 04/19/19 at 01:28pm, Borislav Petkov wrote:
> Why does that "seem" so?
> 
> Read again what I said: "should all be passed through boot_params".
> Which means, boot_params should be extended with a field of a flag to
> say: "this is a kexec'ed kernel".
> 
> If it "seems" then it should be made to not "seem" but to work properly.

No objection to extending with fields of a flag to mark kexec'ed kernel.
Or kdump kernel either. We now check kdump kernel by /proc/vmcore.

> 
> > Yeah, adding the systab mapping looks good. Kairui put it in
> > decompressing stage just because he wants to cover the case in which the
> > old kernel kexec jumping to 2nd kernel. Now it seems not very
> > reasonable, we also have the new kernel kexec jumping to old 2nd kernel.
> 
> I don't think we can guarantee kexec between old<->new kernel to always
> work. Otherwise, we can forget all development and improvements of new
> kernel.

I personally agree with this. Very earlier, we tried to remove the
896 MB limitation of crashkernel=xM, to extend it to 4G or the whole
RAM, but rejcted by linus since he worried it could break the old kernel
kdumping. I may not remember well.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
