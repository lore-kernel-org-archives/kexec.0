Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 2 Oct 2014 15:08:36 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/7] arm64 kexec kernel patches V3
Message-ID: <20141002190836.GA26882@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <20140930202904.GB24153@redhat.com>
 <1412112476.6630.56.camel@smoke>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412112476.6630.56.camel@smoke>
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
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

On Tue, Sep 30, 2014 at 02:27:56PM -0700, Geoff Levand wrote:
> Hi Vivek,
> 
> On Tue, 2014-09-30 at 16:29 -0400, Vivek Goyal wrote:
> > On Thu, Sep 25, 2014 at 12:23:26AM +0000, Geoff Levand wrote:
> > 
> > [..]
> > > To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
> > > kexec-tools [2], which have not yet been merged upstream, are needed.
> > > 
> > > This series does not include some re-work of the spin-table CPU enable method
> > > that is needed to support it,
> > 
> > How do I figure out if my system has spin table enable method or psci
> > enable method. Can one change it. I wanted to test your patches.
> 
> The enable method is a function the firmware/bootloader provides.
> Multiple methods may be supported.  The boot-wrapper-aarch64
> build defaults to spin-table, but has the configure option --enable-psci.
> 
> For a running system you can check the device tree:
> 
>   cat /proc/device-tree/cpus/cpu\@0/enable-method | hexdump -C
> 

Hi Geoff,

So system I have supports spin-table method for cpu bringup. How do I 
test your patches with that system. Are there any patches on your
spin-table branch which can make it working?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
