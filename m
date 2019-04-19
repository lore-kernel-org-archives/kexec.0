Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hHRB9-000221-Hh
 for kexec@lists.infradead.org; Fri, 19 Apr 2019 10:55:36 +0000
Date: Fri, 19 Apr 2019 18:55:29 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190419105529.GF11060@MiWiFi-R3L-srv>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190419105014.GE11060@MiWiFi-R3L-srv>
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

On 04/19/19 at 06:50pm, Baoquan He wrote:
> On 04/19/19 at 12:17pm, Borislav Petkov wrote:
> > Breaking thread because this one got too big.
> > 
> > On Fri, Apr 19, 2019 at 04:34:58PM +0800, Kairui Song wrote:
> > > There are two approach to fix it, detect if the systab is mapped, and
> > > avoid reading it if not.
> > 
> > Ok, so tglx and I discussed this situation which is slowly getting out
> > of hand with all the tinkering.
> > 
> > So, here's what we should do - scream loudly now if some of this doesn't
> > make any sense.
> > 
> > 1. Junichi's patch should get the systab check above added and sent to
> > 5.1 so that at least some EFI kexecing can work with 5.1
> 
> Talked with Kairui privately just now. Seems Junichi's patch need add
> this systab mapping. Since the systab region is not mapped on some
> machines. Those machine don't have this issue because they got systab
> region luckily coverred by 1 GB page mapping in 1st kernel before
> kexec jumping. 
> 
> This issue should happen whether it is KASLR kernel or not KASLR kernel.
> 
> > 
> > 2. Then, the fact whether the kernel has been kexec'ed and which
> > addresses it should use early, should all be passed through boot_params
> > which is either setup by kexec(1) or by the first kernel itself, in the
> > kexec_file_load() case.
> 
> Seems no better way to check if it's kexec-ed kernel, except of the
> setup data checking of kexec-ed kernel.
> 
> It may happen in both kexec_load or kexec_file_load, since we build
> ident mapping of kexec for RAM in 1st kernel.
> 
> > 
> > > the systab region is not mapped by the identity mapping provided by
> > > kexec.
> > 
> > 3. Then that needs to be fixed in the first kernel as it is a
> > shortcoming of us starting to parse systab very early. It is the kexec
> > setup code's problem not the early compressed stage's problem that the
> > EFI systab is not mapped.
> 
> Yeah, adding the systab mapping looks good. Kairui put it in
                                 ^ in 1st kernel
> decompressing stage just because he wants to cover the case in which the
> old kernel kexec jumping to 2nd kernel. Now it seems not very
> reasonable, we also have the new kernel kexec jumping to old 2nd kernel.
> 
> Thanks
> Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
