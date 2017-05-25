Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm01.jp.fujitsu.com ([202.219.69.168])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dDhJu-0006IZ-CT
 for kexec@lists.infradead.org; Thu, 25 May 2017 01:12:08 +0000
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local
 (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
 by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 65DCCAC00FD
 for <kexec@lists.infradead.org>; Thu, 25 May 2017 10:11:35 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH 2/2] Revert "[PATCH V2 1/4] x86_64: Calculate
 page_offset from pt_load"
Date: Thu, 25 May 2017 01:11:32 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20D220286@G01JPEXMBYT03>
References: <33710E6CAA200E4583255F4FB666C4E20D205C05@G01JPEXMBYT03>
 <681cf021-74c0-25d2-a173-23ba50c38cab@redhat.com>
 <449aaa2b-0058-8b4d-227b-df97256b5674@redhat.com>
 <33710E6CAA200E4583255F4FB666C4E20D2060C9@G01JPEXMBYT03>
 <c3807eca-ff7e-73b9-1382-7a92dbed04bb@redhat.com>
 <33710E6CAA200E4583255F4FB666C4E20D21B9BC@G01JPEXMBYT03>
 <7e95a840-2982-90bd-69fc-fe6f55caa0a0@redhat.com>
 <07bb2312-6a8a-b7dd-451e-1ae4a0d726aa@redhat.com>
In-Reply-To: <07bb2312-6a8a-b7dd-451e-1ae4a0d726aa@redhat.com>
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
To: 'Pratyush Anand' <panand@redhat.com>
Cc: "'ats-kumagai@wm.jp.nec.com'" <ats-kumagai@wm.jp.nec.com>, "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>, "'bhe@redhat.com'" <bhe@redhat.com>



> -----Original Message-----
> From: Pratyush Anand [mailto:panand@redhat.com]
> Sent: Wednesday, May 24, 2017 3:21 PM
> To: Hatayama, Daisuke <d.hatayama@jp.fujitsu.com>
> Cc: 'kexec@lists.infradead.org' <kexec@lists.infradead.org>;
> 'bhe@redhat.com' <bhe@redhat.com>; 'ats-kumagai@wm.jp.nec.com'
> <ats-kumagai@wm.jp.nec.com>
> Subject: Re: [PATCH 2/2] Revert "[PATCH V2 1/4] x86_64: Calculate page_offset
> from pt_load"
> 
> 
> 
> On Wednesday 24 May 2017 11:13 AM, Pratyush Anand wrote:
> > Hi Hatayama,
> >
> >
> > On Wednesday 24 May 2017 07:39 AM, Hatayama, Daisuke wrote:
> >> How about this?
> >> - return immediately in case of kaslr because there's no need to refer to
> >> PT_LOAD entries,
> >> - refer to PT_LOAD entries only if they exist, and
> >> - finally try to get page offset according to kernel versions.
> >
> > It looks fine to me.
> > So if you agree then I can send next revision with your "Suggested-by" tag.
> >
> >
> https://github.com/pratyushanand/makedumpfile/commit/16655ce1f4c2da8d40660
> 72db2a03c84bf2553fe
> 
> return TRUEin case of KASLR success was missing in above. Fixed that.
> 
> https://github.com/pratyushanand/makedumpfile/commit/e13807fc6391bf71e7822
> d39cdb084d3bf481818
> 

It looks good to me.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
