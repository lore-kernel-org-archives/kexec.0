Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VvYjD-0004Qm-Dy
 for kexec@lists.infradead.org; Tue, 24 Dec 2013 20:37:24 +0000
Message-ID: <1387917073.1848.7.camel@misato.fc.hp.com>
Subject: Re: [PATCH v7 00/12] kexec kernel efi runtime support
From: Toshi Kani <toshi.kani@hp.com>
Date: Tue, 24 Dec 2013 13:31:13 -0700
In-Reply-To: <20131223073641.GA28919@console-pimps.org>
References: <1387533742-18018-1-git-send-email-dyoung@redhat.com>
 <20131221173515.GE29501@console-pimps.org>
 <1387747621.1848.2.camel@misato.fc.hp.com>
 <20131223073641.GA28919@console-pimps.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Matt Fleming <matt@console-pimps.org>
Cc: "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "msalter@redhat.com" <msalter@redhat.com>, "greg@kroah.com" <greg@kroah.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "leif.lindholm@linaro.org" <leif.lindholm@linaro.org>, "James.Bottomley@HansenPartnership.com" <James.Bottomley@HansenPartnership.com>, "horms@verge.net.au" <horms@verge.net.au>, "bp@alien8.de" <bp@alien8.de>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "mingo@kernel.org" <mingo@kernel.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On Mon, 2013-12-23 at 07:36 +0000, Matt Fleming wrote:
> On Sun, 22 Dec, at 02:27:01PM, Toshi Kani wrote:
> > 
> > The kexec branch is missing the following change, which is required for
> > fast reboot with multi-cpus.
> > 
> >    commit 279f1df915c3a6ed3075d98a849705bf53851f99
> >    Author: Vivek Goyal <vgoyal@redhat.com>
> >    Date:   Tue Nov 26 10:25:28 2013 +0800
> > 
> >        kexec: migrate to reboot cpu
> > 
> > With this change added, I confirmed that the branch kernel works fine.
>  
> I can't find that commit in Linus' tree. Where is it from?

Dave's git tree for the patchset has this change.  This change was
accepted by Vivek, so I think it is in his tree.

Thanks,
-Toshi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
