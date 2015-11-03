Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1446509499.23374.2.camel@infradead.org>
Subject: Re: [PATCH] Revert "kexec: use mmap instead of read for slurp_file()"
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 02 Nov 2015 16:11:39 -0800
In-Reply-To: <20151023031000.GA15557@dhcp-129-115.nay.redhat.com>
References: <20151023031000.GA15557@dhcp-129-115.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>, Simon Horman <horms@verge.net.au>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, kexec@lists.infradead.org

Hi,

On Fri, 2015-10-23 at 11:10 +0800, Dave Young wrote:
> This reverts commit 7ab842d8a004f6cd75a9d7b3528e4a70819ce4ef.
> 
> using mmap by default in slurp_file cause segment fault while later
> reallocing dtb_buf during my arm kexec test.

Could you say more about the cause of the segfault?  Where is the dtb
reallocated?

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
