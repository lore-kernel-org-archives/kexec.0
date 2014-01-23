Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
MIME-version: 1.0
Date: Thu, 23 Jan 2014 15:01:09 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 3/3] ARM: allow kernel to be loaded in middle of phymem
In-reply-to: <20140123193137.GA15937@n2100.arm.linux.org.uk>
Message-id: <alpine.LFD.2.11.1401231443060.1652@knanqh.ubzr>
References: <1390389916-8711-1-git-send-email-wangnan0@huawei.com>
 <1390389916-8711-4-git-send-email-wangnan0@huawei.com>
 <alpine.LFD.2.11.1401231357520.1652@knanqh.ubzr>
 <20140123193137.GA15937@n2100.arm.linux.org.uk>
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Wang Nan <wangnan0@huawei.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Geng Hui <hui.geng@huawei.com>, linux-mm@kvack.org, Eric Biederman <ebiederm@xmission.com>, stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org

On Thu, 23 Jan 2014, Russell King - ARM Linux wrote:

> On Thu, Jan 23, 2014 at 02:15:07PM -0500, Nicolas Pitre wrote:
> > On Wed, 22 Jan 2014, Wang Nan wrote:
> > 
> > > This patch allows the kernel to be loaded at the middle of kernel awared
> > > physical memory. Before this patch, users must use mem= or device tree to cheat
> > > kernel about the start address of physical memory.
> > > 
> > > This feature is useful in some special cases, for example, building a crash
> > > dump kernel. Without it, kernel command line, atag and devicetree must be
> > > adjusted carefully, sometimes is impossible.
> > 
> > With CONFIG_PATCH_PHYS_VIRT the value for PHYS_OFFSET is determined 
> > dynamically by rounding down the kernel image start address to the 
> > previous 16MB boundary.  In the case of a crash kernel, this might be 
> > cleaner to simply readjust __pv_phys_offset during early boot and call 
> > fixup_pv_table(), and then reserve away the memory from the previous 
> > kernel.  That will let you access that memory directly (with gdb for 
> > example) and no pointer address translation will be required.
> 
> We already have support in the kernel to ignore memory below the calculated
> PHYS_OFFSET.  See 571b14375019c3a66ef70d4d4a7083f4238aca30.

Sure.  Anyway what I'm suggesting above  would require that the crash 
kernel be linked at a different virtual address for that to work.  
That's probably more trouble than simply mapping the otherwise still 
unmapped memory from the crashed kernel.


Nicolas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
