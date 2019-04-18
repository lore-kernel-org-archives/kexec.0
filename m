Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hGvmc-0001iv-UD
 for kexec@lists.infradead.org; Thu, 18 Apr 2019 01:24:12 +0000
Date: Thu, 18 Apr 2019 09:24:02 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernels
Message-ID: <20190418012402.GB4977@dhcp-128-65.nay.redhat.com>
References: <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic> <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic> <20190416095209.GG27892@zn.tnic>
 <20190416114133.GA7541@dhcp-128-65.nay.redhat.com>
 <20190416132253.GE31772@zn.tnic>
 <20190417013838.GA8411@dhcp-128-65.nay.redhat.com>
 <20190417082250.GA20492@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190417082250.GA20492@zn.tnic>
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

On 04/17/19 at 10:22am, Borislav Petkov wrote:
> On Wed, Apr 17, 2019 at 09:38:38AM +0800, Dave Young wrote:
> > But if you want to apply it now, I think it is fine as well, probably
> > the laptop issue is lenovo firmware specific, we can add rsdp in cmdline
> > or boot params via kexec-tools so it should be good by using new kexec-tools.
> 
> I'm not in a hurry to apply it - if you guys wanna debug this further,
> sure, we can wait and then tag all the fixes for stable so that they can
> get backported.

Thanks!  According to our debugging this indeed need amending.  We tried
maping the efi systab/acpi table area with some hardcode changes, and
test passed.  This means the previous tests people have done probably
just happened work,  maybe early pg table happen to cover the memory
areas in their cases.  We noticed in vm guest and some other machines, the systab
all fall into memory under 2G, but the systab of T420 sits in area
0xda...... which is 2G ~ 4G area.

Kairui is trying to work on some fix so that it can be folded into the
current reviewed patch.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
