Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ9rG-0065Yf-Ci
 for kexec@lists.infradead.org; Tue, 14 Sep 2021 14:56:29 +0000
Date: Tue, 14 Sep 2021 16:56:09 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
Message-ID: <YUC4CW02tqEttZZJ@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic>
 <41b93dae-2f10-15a3-a079-c632381bec73@csgroup.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41b93dae-2f10-15a3-a079-c632381bec73@csgroup.eu>
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
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, linux-graphics-maintainer@vmware.com, Tom Lendacky <thomas.lendacky@amd.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Tue, Sep 14, 2021 at 04:47:41PM +0200, Christophe Leroy wrote:
> Yes, see https://lore.kernel.org/linuxppc-dev/20210914123919.58203eef@canb.auug.org.au/T/#t

Aha, more compiler magic stuff ;-\

Oh well, I guess that fix will land upstream soon.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
