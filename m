Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZEpi-00D01p-Or
 for kexec@lists.infradead.org; Wed, 21 Apr 2021 15:32:10 +0000
Date: Wed, 21 Apr 2021 17:32:02 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v13 12/12] x86/kvm: Add guest support for detecting and
 enabling SEV Live Migration feature.
Message-ID: <20210421153202.GC5004@zn.tnic>
References: <cover.1618498113.git.ashish.kalra@amd.com>
 <ffd67dbc1ae6d3505d844e65928a7248ebaebdcc.1618498113.git.ashish.kalra@amd.com>
 <20210421144402.GB5004@zn.tnic>
 <20210421152220.GB14004@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210421152220.GB14004@ashkalra_ubuntu_server>
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
To: Ashish Kalra <ashish.kalra@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, joro@8bytes.org, thomas.lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, srutherford@google.com, seanjc@google.com, venu.busireddy@oracle.com, brijesh.singh@amd.com, kexec@lists.infradead.org

On Wed, Apr 21, 2021 at 03:22:20PM +0000, Ashish Kalra wrote:

> Yes, the above mentions to get KVM_FEATURE_CPUID and then check if live
> migration feature is supported, i.e.,
> kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION). The above comments
> are written more generically.

Do not write generic comments please - write exact comments to state
precisely why you're doing what you're doing.

> Just to ensure that the sev_live_migration_enabled is set to TRUE before
> it is used immediately next in the function.

Why wouldn't it be set to true by the time the next function runs?

Do you have any concrete observations where this is not the case?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
