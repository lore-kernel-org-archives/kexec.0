Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0Loz-0003TC-Sg
 for kexec@lists.infradead.org; Tue, 07 Jan 2014 01:51:11 +0000
Date: Tue, 7 Jan 2014 09:49:48 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: clean up draft patch
Message-ID: <20140107014948.GA32590@dhcp-16-105.nay.redhat.com>
References: <1388146378-25419-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1388146378-25419-1-git-send-email-bhe@redhat.com>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

Hi Atsushi,

Could you please review this draft patch? As we discussed before,
function update_cyclic_region not only update the cyclic region, but
also handle the 1st bitmap and 2nd bitmap. For better understanding and
process, it need be cleaned up. In this patch, struct cycle is
introduced and can be passed down into functions, but not global. I
think this clean up is helpful, and no risk.

What'a your opinion?

Baoquan
Thanks


On 12/27/13 at 08:12pm, Baoquan He wrote:
> Introduce the struct cycle as below just as Hatamaya expected.
> struct cycle {
>         uint64_t start_pfn;
>         uint64_t end_pfn;
> };
> 
>   for (first_cycle(start, max, C); !end_cycle(max, C); \
>        update_cycle(max, C))
> 
> Hi Atsushi and HATAYAMA,
> 
> Please help review this draft patch and check if there's any potentia
> risk. If you think this is in the right way, I can post a formal
> patchset. I just test the normal operation on kdump and elf format,
> it works well.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
