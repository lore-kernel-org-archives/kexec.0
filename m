Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loEBk-001HZZ-5r
 for kexec@lists.infradead.org; Tue, 01 Jun 2021 23:52:49 +0000
Date: Tue, 1 Jun 2021 16:52:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V2 4/6] mm: rename the global section array to mem_sections
Message-Id: <20210601165246.99d7374d07661b7e91e49cb6@linux-foundation.org>
In-Reply-To: <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com>
 <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
 <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
 <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: Dong Aisheng <dongas86@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org, open list <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

On Tue, 1 Jun 2021 10:40:09 +0200 David Hildenbrand <david@redhat.com> wrote:

> > Thanks, i explained the reason during my last reply.
> > Andrew has already picked this patch to -mm tree.
> 
> Just because it's in Andrews tree doesn't mean it will end up upstream. ;)
> 
> Anyhow, no really strong opinion, it's simply unnecessary code churn 
> that makes bisecting harder without real value IMHO.

I think it's a good change - mem_sections refers to multiple instances
of a mem_section.  Churn is a pain, but that's the price we pay for more
readable code.  And for having screwed it up originally ;)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
