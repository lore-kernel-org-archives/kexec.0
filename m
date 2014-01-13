Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W2hbV-000792-4W
 for kexec@lists.infradead.org; Mon, 13 Jan 2014 13:30:58 +0000
Date: Mon, 13 Jan 2014 07:30:33 -0600
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: [PATCH 1/2 V2] raw i/o and root device to use less memory
Message-ID: <20140113133033.GA917@sgi.com>
References: <E1Vy8l7-0004oL-7v@eag09.americas.sgi.com>
 <20140110175830.GA7498@sgi.com> <20140113105831.57412728@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140113105831.57412728@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

On Mon, Jan 13, 2014 at 10:58:31AM +0100, Michael Holzheu wrote:
> On Fri, 10 Jan 2014 11:58:30 -0600
> Cliff Wickman <cpw@sgi.com> wrote:
> 
> [snip]
> 
> > Use O_DIRECT (raw) i/o for the dump and for the bitmaps file, so that writing
> > to those files does not allocate kernel memory for page cache.
> 
> Hello Cliff,
> 
> Have you tested O_DIRECT together with the new vmcore mmap interface?
> IIRC when we tried O_DIRECT together with mmap for some reason it did
> not work.
> 
> Michael

Hi Michael,

  How new of a kernel do I need?  i.e. how 'new' of an mmap interface?
  The latest kernel I used was 3.0.93 (sle11sp3).
  And makedumpfile was 1.5.5.

-Cliff
-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
