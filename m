Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410088.outbound.protection.outlook.com
 ([40.107.141.88] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLc62-0089rS-9K
 for kexec@lists.infradead.org; Thu, 02 Sep 2021 02:04:58 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH 1/1] fix left bit-shift overflow in
 __exclude_unnecessary_pages()
Date: Thu, 2 Sep 2021 02:04:44 +0000
Message-ID: <TYYPR01MB677711D49045BA1E6508C648DDCE9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <TYYPR01MB67777DFB702E9801AA414B6ADDCD9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <87v93ksl0q.fsf@oc8242746057.ibm.com>
In-Reply-To: <87v93ksl0q.fsf@oc8242746057.ibm.com>
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
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Discussion list
 for crash utility usage, 	maintenance and development" <crash-utility@redhat.com>

-----Original Message-----
> > -----Original Message-----
> >> Whenever the variables compound_order or private become greater than
> >> 31, left bit-shift of 1 overflows, and nr_pages becomes zero. If nr_pages
> >> becomes 0 and pages are being excluded at the end of the PFN loop, the
> >> else branch of the last if statement is entered and pfn is decremented by
> >> 1 because nr_pages is 0. Finally, this causes the loop variable pfn to
> >> be assigned the same value as before when the next loop iteration begins
> >> which results in an infinite loop.
> >>
> >> This issue appeared on s390 64bit architecture with a dump of 16GB RAM.
> >
> > The patch looks good to me, but just out of curiosity, when do the
> > compound_order or private become greater than 31 on s390?
> >
> > Thanks,
> > Kazu
> >
> 
> I added some debug statements and this what i got:
> 
> compound_order 0
> compound_order 1
> compound_order 2
> compound_order 3
> compound_order 4
> compound_order 5
> compound_order 6
> compound_order 7
> compound_order 8
> private 0
> private 1
> private 2
> private 3
> private 4
> private 5
> private 52
> private 6
> private 7
> private 8
> 
> It seems that not compound_order but private is at fault here and
> triggers the bug. Not sure yet what that exactly means and whether we
> have here another bug which triggers this one :/

Hmm, so makedumpfile will exclude many pages wrongly with the patch?
Excluding pages wrongly is better than failing with an infinite loop,
but not better than including pages wrongly, because it might lose
necessary data for investigation.

So I think we should have a sanity check also for the private.  AFAIK,
the private value (buddy allocator's order) should be less than MAX_ORDER.
If this is correct, we can use LENGTH(zone.free_area) in vmcoreinfo.

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
