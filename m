Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wknh5-0001oO-Th
 for kexec@lists.infradead.org; Thu, 15 May 2014 04:55:00 +0000
Date: Thu, 15 May 2014 13:54:40 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/ppc64: Handle reserved memory ranges exported by
 OPAL firmware.
Message-ID: <20140515045440.GC778@verge.net.au>
References: <20140209165544.29624.91745.stgit@mars>
 <20140510235144.GK31760@verge.net.au>
 <53704F48.1030903@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53704F48.1030903@linux.vnet.ibm.com>
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
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Laurent Dufour <ldufour@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>

On Mon, May 12, 2014 at 10:04:16AM +0530, Mahesh Jagannath Salgaonkar wrote:
> On 05/11/2014 05:21 AM, Simon Horman wrote:
> > On Sun, Feb 09, 2014 at 10:25:45PM +0530, Mahesh J Salgaonkar wrote:
> >> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >>
> >> OPAL based system exports reserved memory ranges through /proc/device-tree
> >> for the regions that are reserved by OPAL firmware. Traverse
> >> /proc/device-tree/reserved-ranges and add them to exclude_ranges[] and
> >> reserve them.
> >>
> >> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > 
> > I apologise that this seems to have slipped through the cracks.
> > Manesh, is this patch still needed?
> 
> Yup. We need this also.

Thanks, I have applied this too.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
