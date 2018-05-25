Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fM9U2-0005z0-Ja
 for kexec@lists.infradead.org; Fri, 25 May 2018 09:58:04 +0000
Date: Fri, 25 May 2018 11:57:43 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] vmcore-dmesg: fix infinite loop if log buffer wraps around
Message-ID: <20180525095742.p3gxjhmft43lxpi4@verge.net.au>
References: <931590ebae2be0563ab6fdfa17c84111f393904b.1527108991.git.osandov@fb.com>
 <20180524020717.GB24627@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180524020717.GB24627@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: Omar Sandoval <osandov@osandov.com>, kexec@lists.infradead.org, kernel-team@fb.com

On Thu, May 24, 2018 at 10:07:17AM +0800, Baoquan He wrote:
> On 05/23/18 at 01:59pm, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > We hit a bug where vmcore-dmesg would get stuck in a loop, and since we
> > were redirecting the output to a file, it wouldn't stop until it filled
> > up the disk. This only happened when the dmesg buffer had filled up and
> > wrapped around. It turns out that when we hit the end of the buffer, we
> > are looping back to the first record instead of the beginning of the
> > buffer, which will always loop forever.
> > 
> > Fixes: e08d26b3b7f1 ("vmcore-dmesg: avoid allocating large memory chunk for log buf")
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  vmcore-dmesg/vmcore-dmesg.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
> > index e340ef4..7972788 100644
> > --- a/vmcore-dmesg/vmcore-dmesg.c
> > +++ b/vmcore-dmesg/vmcore-dmesg.c
> > @@ -689,7 +689,7 @@ static void dump_dmesg_structured(int fd)
> >  		 */
> >  		loglen = struct_val_u16(buf, log_offset_len);
> >  		if (!loglen)
> > -			current_idx = log_first_idx;
> > +			current_idx = 0;
> 
> Looks like a good fix, ack it.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
> Strange it isn't found until now, the case which log_next_idx is before
> log_first_idx sholdn't be seen rarely.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
