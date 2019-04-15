Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hFvdd-0003gD-Fn
 for kexec@lists.infradead.org; Mon, 15 Apr 2019 07:02:47 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Date: Mon, 15 Apr 2019 07:01:54 +0000
Message-ID: <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
References: <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411083738.GC30080@zn.tnic>
 <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
 <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
 <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
 <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
 <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic> <20190412133528.GD19808@zn.tnic>
In-Reply-To: <20190412133528.GD19808@zn.tnic>
Content-Language: ja-JP
Content-ID: <94E790B68FB193469C00239E878FC0EC@gisp.nec.co.jp>
MIME-Version: 1.0
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
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>

On 4/12/19 10:35 PM, Borislav Petkov wrote:
> On Fri, Apr 12, 2019 at 10:49:56AM +0200, Borislav Petkov wrote:
>> Now I need to go figure out whether there's a reliable way to know in
>> the kexec kernel that it *is* a kexec kernel.
> 
> Actually, thinking about this more, we don't need to know whether the
> kernel was kexeced or not. Why?
> 
> Because if it is kexec'ed, kexec(1) passes the required info in
> setup_data. Now, if for whatever reason the kexec'ed kernel fails to
> parse that EFI info and get the systab to figure out the RDSP, then it
> doesn't have any other choice but fail booting.
> 
> Because there's no way it can figure out where the EFI runtime has been
> mapped and recover by finding the RDSP from there.
> 
> So I think we're perfectly fine with the old approach:
> 
>         if (!pa)
>                 pa = kexec_get_rsdp_addr();
> 
>         if (!pa)
>                 pa = efi_get_rsdp_addr();

OK. Then I'll go back to v3 and make sure to hang when
something is wrong during kexec boot on EFI system.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
