Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-x236.google.com ([2607:f8b0:400e:c02::236])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZJwio-0007mu-Qs
 for kexec@lists.infradead.org; Tue, 28 Jul 2015 04:42:35 +0000
Received: by pdbnt7 with SMTP id nt7so63638418pdb.0
 for <kexec@lists.infradead.org>; Mon, 27 Jul 2015 21:42:13 -0700 (PDT)
Date: Tue, 28 Jul 2015 12:42:08 +0800
From: Minfei Huang <mnfhuang@gmail.com>
Subject: Re: [PATCH] kexec: Remove the unnecessary conditional judgement to
 simplify the code logic
Message-ID: <20150728044208.GA32290@t440s.lenovo>
References: <1433571252-11874-1-git-send-email-mhuang@redhat.com>
 <20150727134453.GA16064@redhat.com>
 <20150728043019.GC25714@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150728043019.GC25714@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: Minfei Huang <mhuang@redhat.com>, kexec@lists.infradead.org, ebiederm@xmission.com, Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org

On 07/28/15 at 01:30pm, Simon Horman wrote:
> On Mon, Jul 27, 2015 at 09:44:53AM -0400, Vivek Goyal wrote:
> > On Sat, Jun 06, 2015 at 02:14:12PM +0800, Minfei Huang wrote:
> > > From: Minfei Huang <mnfhuang@gmail.com>
> > > 
> > > Transforming PFN(Page Frame Number) to struct page is never failure, so
> > > we can simplify the code logic to do the image->control_page assignment
> > > directly in the loop, and remove the unnecessary conditional judgement.
> > > 
> > > Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> > 
> > Looks good to me.
> > 
> > Acked-by: Vivek Goyal <vgoyal@redhat.com>
> 
> FWIW, this probably needs to be reposted to Andrew Morton with appropriate
> Acks and CCs in order to proceed into his tree and then Linus's.

Thanks.

I will repost it to Andrew Morton.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
