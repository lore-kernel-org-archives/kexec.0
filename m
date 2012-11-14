Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TYjN5-0008A0-Oe
 for kexec@lists.infradead.org; Wed, 14 Nov 2012 20:15:41 +0000
Date: Wed, 14 Nov 2012 15:15:27 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
Message-ID: <20121114201527.GM20215@redhat.com>
References: <20121108133554.28410.99763.stgit@aravinda>
 <20121114145445.GC20215@redhat.com>
 <50A3CFAD.6090008@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50A3CFAD.6090008@linux.vnet.ibm.com>
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
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, Dave Anderson <anderson@redhat.com>, buendgen@de.ibm.com

On Wed, Nov 14, 2012 at 10:36:53PM +0530, Aravinda Prasad wrote:

[..]
> The main intention is to remove confidential information from the dump
> file, like ssh keys etc., which could be just few bytes, hence, may not
> reduce the size of the dump significantly.

Where are these ssh keys? Are these in user space memory or kernel memory?
How would one know the location of these keys?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
