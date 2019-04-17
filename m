Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hGZXF-0002yS-6M
 for kexec@lists.infradead.org; Wed, 17 Apr 2019 01:38:50 +0000
Date: Wed, 17 Apr 2019 09:38:38 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernels
Message-ID: <20190417013838.GA8411@dhcp-128-65.nay.redhat.com>
References: <20190412084956.GC19808@zn.tnic> <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic> <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic> <20190416095209.GG27892@zn.tnic>
 <20190416114133.GA7541@dhcp-128-65.nay.redhat.com>
 <20190416132253.GE31772@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190416132253.GE31772@zn.tnic>
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
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Junichi Nomura <j-nomura@ce.jp.nec.com>

On 04/16/19 at 03:22pm, Borislav Petkov wrote:
> On Tue, Apr 16, 2019 at 07:41:33PM +0800, Dave Young wrote:
> > On 04/16/19 at 11:52am, Borislav Petkov wrote:
> > > I'll queue the below in the next days if there are no more complaints:
> > 
> > As for the kexec breakage, even with the V3 patch, kexec still hangs on
> > a Lenovo T420 laptop.  Kairui also reproduced the problem. So can we
> > wait a few days see if we can make some progress to find the cause?
> 
> How is applying this patch going to change anything?
> 
> I was told that the breakage is there even without it...

Without this patch, the bug happens in the efi_get_rsdp.. function, this
patch tries to fix that by adding kexec_get.. but the new introduced
kexec_* function does not work on some laptops, so it is not a 100% good
fix, I hoped we can get it working for all known issues.  But if we can
not do it eg. within one week we can go with this version and leave the
laptop issue as a known issue.

But if you want to apply it now, I think it is fine as well, probably
the laptop issue is lenovo firmware specific, we can add rsdp in cmdline
or boot params via kexec-tools so it should be good by using new kexec-tools.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
