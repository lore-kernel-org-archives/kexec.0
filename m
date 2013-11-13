Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vgj7o-0007CY-EP
 for kexec@lists.infradead.org; Wed, 13 Nov 2013 22:41:29 +0000
Date: Wed, 13 Nov 2013 17:41:04 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: /proc/vmcore mmap() failure issue
Message-ID: <20131113224104.GF7613@redhat.com>
References: <20131113204130.GD7613@redhat.com>
 <20131113210432.GE7613@redhat.com> <5283EBCD.6070305@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5283EBCD.6070305@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

On Wed, Nov 13, 2013 at 01:14:53PM -0800, H. Peter Anvin wrote:
> On 11/13/2013 01:04 PM, Vivek Goyal wrote:
> > [CC hpa ]
> > 
> > And this issue brings me to the question that why do we allow sytem RAM
> > ranges which do not start on page boundary or do not end on page boundary. 
> > Can't we truncate the BIOS reported RAM ranges in such a way so that
> > they start and end at PAGE boundary and rest of the kernel will never see
> > unaligned portion of RAM and this will make life so much simpler for
> > other tools.
> > 
> 
> That is a bit of a headache for doing in the memblock space.  We do, in
> fact, truncate partial pages, but later in the game.  It is possible we
> should push that sooner in the stack.

Hi Peter,

I noticed we seem to be trimming away partial pages in memblock.

memblock_x86_fill() {
	/* throw away partial pages */
        memblock_trim_memory(PAGE_SIZE);
}

But not in e820 hence they show up in /proc/iomem.

How about something along the lines as below patch. This fixes my
/proc/vmcore mmap() issue.

Thanks
Vivek


---
 arch/x86/kernel/e820.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

Index: linux-2.6/arch/x86/kernel/e820.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/e820.c	2013-11-13 10:46:24.938057251 -0500
+++ linux-2.6/arch/x86/kernel/e820.c	2013-11-13 17:36:17.042681842 -0500
@@ -169,6 +169,33 @@ void __init e820_print_map(char *who)
 	}
 }
 
+static int e820_trim_memory(struct e820entry *map, unsigned int nr_entries,
+				unsigned int align)
+{
+	int i;
+	struct e820entry *ei;
+	u64 start, end, orig_start, orig_end;
+
+	for (i = 0; i < nr_entries; i++) {
+		ei = &map[i];
+		if (ei->type != E820_RAM)
+			continue;
+		orig_start = ei->addr;
+		orig_end = ei->addr + ei->size;
+
+		start = round_up(orig_start, align);
+		end = round_down(orig_end, align);
+
+		if (start == orig_start && end == orig_end)
+			continue;
+
+		ei->addr = start;
+		ei->size = end - start;
+	}
+
+	return 0;
+}
+
 /*
  * Sanitize the BIOS e820 map.
  *
@@ -267,6 +294,8 @@ int __init sanitize_e820_map(struct e820
 	int old_nr, new_nr, chg_nr;
 	int i;
 
+	e820_trim_memory(biosmap, *pnr_map, PAGE_SIZE);
+
 	/* if there's only one memory region, don't bother */
 	if (*pnr_map < 2)
 		return -1;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
