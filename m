Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TWpOb-0003YO-8H
 for kexec@lists.infradead.org; Fri, 09 Nov 2012 14:17:22 +0000
Date: Fri, 9 Nov 2012 09:17:17 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/3] makedumpfile: calculate the size of cyclic buffer
 automatically.
Message-ID: <20121109141717.GB4842@redhat.com>
References: <20121109160214.afe15ee1a047ff7354471ba0@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121109160214.afe15ee1a047ff7354471ba0@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

On Fri, Nov 09, 2012 at 04:02:14PM +0900, Atsushi Kumagai wrote:
> Hello,
> 
> I made the patch set based on v1.5.1-beta to calculate the size of cyclic 
> buffer automatically.
> 
> In v1.5.0, users have to specify the buffer size depending on system memory
> size with --cyclic-buffer option in order to get decent performance.
> 
> This patch set avoids the inconvenience above by choosing the lesser value
> of the two below as the size of cyclic buffer automatically:
> 
>   a. the size enough for storing the 1st/2nd bitmap for the whole of vmcore
>   b. 80% of free memory (as safety limit)
> 
> Additionally, this patch set remove --cyclic-buffer option because I think
> it has been already unnecessary.

I was wondering how about retaining --cyclic-buffer <size> option. If 
there are use cases where user's don't like default of 80% of free memory
they can override this policy by specifying --cyclic-buffer.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
