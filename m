Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1412290795.32313.14.camel@smoke>
Subject: Re: [PATCH 0/7] arm64 kexec kernel patches V3
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 02 Oct 2014 15:59:55 -0700
In-Reply-To: <20141002190836.GA26882@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <20140930202904.GB24153@redhat.com> <1412112476.6630.56.camel@smoke>
 <20141002190836.GA26882@redhat.com>
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

Hi Vivek,

On Thu, 2014-10-02 at 15:08 -0400, Vivek Goyal wrote:
> On Tue, Sep 30, 2014 at 02:27:56PM -0700, Geoff Levand wrote:
> > For a running system you can check the device tree:
> > 
> >   cat /proc/device-tree/cpus/cpu\@0/enable-method | hexdump -C
> > 
> 
> So system I have supports spin-table method for cpu bringup. How do I 
> test your patches with that system. Are there any patches on your
> spin-table branch which can make it working?

If possible, check if there is a firmware update that supports PSCI.

My spin-table patches are now out of date, and fixing those up is
now low priority.

I modified kexec-tools to only issue a message, but accept a device
tree that does not have the new cpu-return-addr property that is
needed for kexec on spin-table systems.  Since the spin-table stuff
is only for managing secondary CPUs, this change should allow you to
test kexec with a 1st stage kernel built with CONFIG_SMP=n.

Since the secondary CPUs will have never left the spin-table, you
should be able to kexec re-boot into an SMP kernel, but you will
not be able to do a successful kexec re-boot from there.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
