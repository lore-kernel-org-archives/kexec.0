Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 7 Oct 2014 16:22:10 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 6/7] arm64/kexec: Add core kexec support
Message-ID: <20141007202210.GA4236@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001145602.GB13689@redhat.com>
 <1412361303.32313.24.camel@smoke>
 <20141007134450.GE27464@redhat.com>
 <1412707320.32313.100.camel@smoke>
 <20141007184520.GI27464@redhat.com>
 <1412712777.32313.130.camel@smoke>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412712777.32313.130.camel@smoke>
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

On Tue, Oct 07, 2014 at 01:12:57PM -0700, Geoff Levand wrote:
> Hi Vivek,
> 
> On Tue, 2014-10-07 at 14:45 -0400, Vivek Goyal wrote:
> > On Tue, Oct 07, 2014 at 11:42:00AM -0700, Geoff Levand wrote:
> > > Adding purgatory code to arm64 is low priority, and I currently
> > > have no plan to do that.  Users are asking for kdump, and proper
> > > UEFI support, so that is what I will work towards.
> > 
> > I think having purgatory enabled is very important here as in kernel
> > you are hardcoding that one of the segments is DTB and doing all the
> > magic tricks w.r.t putting a magic number. 
> 
> I don't argue that having purgatory code could be useful, but as of
> now, enabling the other features is what I'll work towards.
>  
> Regarding the device tree magic number, I'm wondering if you missed
> that the device tree has a header, and that header has a magic
> number.  See here:
> 
>   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/dtc/libfdt/fdt.h#n6
> 

Problem is this that if you put code in kernel once which does something
which purgatory ought to do, you will never be able to remove it for
backward compatibility reasons. Older versions of kexec-tools will 
continue to rely on it. Also how in kernel you would know that now
purgatory will take care of this and kernel does not have to worry
about something. So it is a good idea to integrate the purgatory support
from the very beginning.

Also, verifying checksums of loaded segments before jumping to that kernel
is a must from feature point of view.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
