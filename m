Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGIZU-0003o2-8Q
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 00:32:34 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B1AFB3EE0C0
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 09:32:26 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 95EDE45DE58
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 09:32:26 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 736A645DE5B
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 09:32:26 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 617AB1DB8052
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 09:32:26 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 182791DB8050
 for <kexec@lists.infradead.org>; Fri, 15 Mar 2013 09:32:26 +0900 (JST)
Date: Fri, 15 Mar 2013 09:31:46 +0900 (JST)
Message-Id: <20130315.093146.401285457.d.hatayama@jp.fujitsu.com>
Subject: makedumpfile: question about memory hole
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

Hello Kumagai-san,

I have a question about memory hole.

For example, create_1st_bitmap() calculates memory holes in the part
below:

int
create_1st_bitmap(void)
{
...
        /*
         * If page is on memory hole, set bit on the 1st-bitmap.
         */
        pfn_bitmap1 = 0;
        for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {

                print_progress(PROGRESS_HOLES, i, num_pt_loads);

                pfn_start = paddr_to_pfn(phys_start);
                pfn_end   = paddr_to_pfn(phys_end);

                if (!is_in_segs(pfn_to_paddr(pfn_start)))
                        pfn_start++;
                for (pfn = pfn_start; pfn < pfn_end; pfn++) {
                        set_bit_on_1st_bitmap(pfn);
                        pfn_bitmap1++;
                }
        }
        pfn_memhole = info->max_mapnr - pfn_bitmap1;

What I don't understand well is that the part here:

                pfn_start = paddr_to_pfn(phys_start);
                pfn_end   = paddr_to_pfn(phys_end);

                if (!is_in_segs(pfn_to_paddr(pfn_start)))
                        pfn_start++;

phys_start and pfn_to_paddr(pfn_start) should belong to the same page
frame, so I suspect the pfn_start should be included in vmcore.

Looking into kexec-tool side, I don't see additional modification made
to phys_start after it's parsed from /proc/iomem or counterpart on EFI
interface. Is there any assumption about memory holes behind kernel?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
