Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fL2OT-0003Ce-FN
 for kexec@lists.infradead.org; Tue, 22 May 2018 08:11:44 +0000
Date: Tue, 22 May 2018 10:11:04 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/s390: Add support for kexec_file_load
Message-ID: <20180522081104.calxgxzxel4fqh6j@verge.net.au>
References: <20180516122718.15440-1-prudo@linux.ibm.com>
 <20180521062440.GB6036@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180521062440.GB6036@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Philipp Rudo <prudo@linux.ibm.com>, linux-s390@vger.kernel.org, kexec@lists.infradead.org

On Mon, May 21, 2018 at 02:24:40PM +0800, Dave Young wrote:
> On 05/16/18 at 02:27pm, Philipp Rudo wrote:
> > Since kernel 4.17-rc2 s390 supports the kexec_file_load system call. Add
> > the new system call to kexec-tools and provide the -s (--kexec-file-syscall)
> > option for s390 to support this new feature.
> > 
> > Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>

...

> Acked-by: Dave Young <dyoung@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
