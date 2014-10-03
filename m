Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1412370971.32313.30.camel@smoke>
Subject: Re: [PATCH 0/7] arm64 kexec kernel patches V3
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 03 Oct 2014 14:16:11 -0700
In-Reply-To: <20141001151947.GB14991@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141001151947.GB14991@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

Hi,

On Wed, 2014-10-01 at 11:19 -0400, Vivek Goyal wrote:
> On Thu, Sep 25, 2014 at 12:23:26AM +0000, Geoff Levand wrote:
> > Hi All,
> > 
> > This series adds the core support for kexec re-boots on arm64.  I have tested
> > with the ARM VE fast model using various kernel config options for both the
> > first and second stage kernels.
> 
> Does this patch series work with kexec on UEFI machines?

I have not done much more than some simple re-boot tests using the
base model (FVP_Base_AEMv8A-AEMv8A) and the Linaro 14.08 efi build,
but yes, it should work.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
