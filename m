Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 16 Sep 2021 08:35:16 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
Message-ID: <YULztMRLJ55YLVU9@infradead.org>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic> <87lf3yk7g4.fsf@mpe.ellerman.id.au>
 <YUHGDbtiGrDz5+NS@zn.tnic>
 <f8388f18-5e90-5d0f-d681-0b17f8307dd4@csgroup.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8388f18-5e90-5d0f-d681-0b17f8307dd4@csgroup.eu>
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
Cc: Borislav Petkov <bp@alien8.de>, Michael Ellerman <mpe@ellerman.id.au>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, linux-graphics-maintainer@vmware.com, Tom Lendacky <thomas.lendacky@amd.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Wed, Sep 15, 2021 at 07:18:34PM +0200, Christophe Leroy wrote:
> Could you please provide more explicit explanation why inlining such an
> helper is considered as bad practice and messy ?

Because now we get architectures to all subly differ.  Look at the mess
for ioremap and the ioremap* variant.

The only good reason to allow for inlines if if they are used in a hot
path.  Which cc_platform_has is not, especially not on powerpc.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
