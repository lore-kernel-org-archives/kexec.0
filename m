Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 7 Oct 2014 09:40:06 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/7] arm64 kexec kernel patches V3
Message-ID: <20141007134006.GC27464@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141001151947.GB14991@redhat.com>
 <1412370971.32313.30.camel@smoke>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412370971.32313.30.camel@smoke>
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
To: Geoff Levand <geoff@infradead.org>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, christoffer.dall@linaro.org

On Fri, Oct 03, 2014 at 02:16:11PM -0700, Geoff Levand wrote:
> Hi,
> 
> On Wed, 2014-10-01 at 11:19 -0400, Vivek Goyal wrote:
> > On Thu, Sep 25, 2014 at 12:23:26AM +0000, Geoff Levand wrote:
> > > Hi All,
> > > 
> > > This series adds the core support for kexec re-boots on arm64.  I have tested
> > > with the ARM VE fast model using various kernel config options for both the
> > > first and second stage kernels.
> > 
> > Does this patch series work with kexec on UEFI machines?
> 
> I have not done much more than some simple re-boot tests using the
> base model (FVP_Base_AEMv8A-AEMv8A) and the Linaro 14.08 efi build,
> but yes, it should work.

[CC Dave Young ]

I have not looked at the user space patches but are you preparing efi
setup data and passing all the runtime map information to second kernel.

I am hoping on arm64 we have the CONFIG_EFI_RUNTIME_MAP=y and it works
well.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
