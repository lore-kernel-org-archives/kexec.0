Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1412712777.32313.130.camel@smoke>
Subject: Re: [PATCH 6/7] arm64/kexec: Add core kexec support
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 07 Oct 2014 13:12:57 -0700
In-Reply-To: <20141007184520.GI27464@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com> <1412106877.6630.45.camel@smoke>
 <20141001145602.GB13689@redhat.com> <1412361303.32313.24.camel@smoke>
 <20141007134450.GE27464@redhat.com> <1412707320.32313.100.camel@smoke>
 <20141007184520.GI27464@redhat.com>
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

On Tue, 2014-10-07 at 14:45 -0400, Vivek Goyal wrote:
> On Tue, Oct 07, 2014 at 11:42:00AM -0700, Geoff Levand wrote:
> > Adding purgatory code to arm64 is low priority, and I currently
> > have no plan to do that.  Users are asking for kdump, and proper
> > UEFI support, so that is what I will work towards.
> 
> I think having purgatory enabled is very important here as in kernel
> you are hardcoding that one of the segments is DTB and doing all the
> magic tricks w.r.t putting a magic number. 

I don't argue that having purgatory code could be useful, but as of
now, enabling the other features is what I'll work towards.
 
Regarding the device tree magic number, I'm wondering if you missed
that the device tree has a header, and that header has a magic
number.  See here:

  http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/dtc/libfdt/fdt.h#n6

-Geoff







_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
