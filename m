Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from usmamail.tilera.com ([12.216.194.151])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Ti52n-0007oS-BM
 for kexec@lists.infradead.org; Mon, 10 Dec 2012 15:13:21 +0000
Message-ID: <50C5FC06.8020104@tilera.com>
Date: Mon, 10 Dec 2012 10:13:10 -0500
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/8] mm,
 vmalloc: change iterating a vmlist to find_vm_area()
References: <1354810175-4338-1-git-send-email-js1304@gmail.com>
 <1354810175-4338-2-git-send-email-js1304@gmail.com>
In-Reply-To: <1354810175-4338-2-git-send-email-js1304@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joonsoo Kim <js1304@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>

On 12/6/2012 11:09 AM, Joonsoo Kim wrote:
> The purpose of iterating a vmlist is finding vm area with specific
> virtual address. find_vm_area() is provided for this purpose
> and more efficient, because it uses a rbtree.
> So change it.

If you get an Acked-by for the x86 change, feel free to apply it to the tile file as well.  You'll note that for tile it's under an #if 0, which in retrospect I shouldn't have pushed anyway.  So I don't feel strongly :-)

FWIW, the change certainly seems at least plausible to me.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
