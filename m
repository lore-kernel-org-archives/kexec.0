Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410081.outbound.protection.outlook.com
 ([40.107.141.81] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loFPf-001RrE-R6
 for kexec@lists.infradead.org; Wed, 02 Jun 2021 01:11:17 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH V2 4/6] mm: rename the global section array to mem_sections
Date: Wed, 2 Jun 2021 01:11:07 +0000
Message-ID: <TYYPR01MB67775E2EC60DEE1195A49577DD3D9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com>
 <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
 <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
 <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
 <20210601165246.99d7374d07661b7e91e49cb6@linux-foundation.org>
In-Reply-To: <20210601165246.99d7374d07661b7e91e49cb6@linux-foundation.org>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>
Cc: Dong Aisheng <dongas86@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

-----Original Message-----
> On Tue, 1 Jun 2021 10:40:09 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
> > > Thanks, i explained the reason during my last reply.
> > > Andrew has already picked this patch to -mm tree.
> >
> > Just because it's in Andrews tree doesn't mean it will end up upstream. ;)
> >
> > Anyhow, no really strong opinion, it's simply unnecessary code churn
> > that makes bisecting harder without real value IMHO.
> 
> I think it's a good change - mem_sections refers to multiple instances
> of a mem_section.  Churn is a pain, but that's the price we pay for more
> readable code.  And for having screwed it up originally ;)

From a makedumpfile/crash-utility viewpoint, I don't deny kernel improvement
and probably the change will not be hard for them to support, but I'd like
you to remember that the tool users will need to update them for the change.

The situation where we need to update the tools for new kernels is usual, but
there are not many cases that they cannot even start session, and this change
will cause it.  Personally I wonder the change is worth forcing users to update
them.

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
