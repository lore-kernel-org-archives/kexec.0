Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WC3wV-0001kE-Kh
 for kexec@lists.infradead.org; Sat, 08 Feb 2014 09:11:24 +0000
Date: Sat, 8 Feb 2014 17:09:47 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [v2 2/3] makedumpfile: use struct cycle to update cyclic region
 and clean up
Message-ID: <20140208090947.GC25133@dhcp-16-105.nay.redhat.com>
References: <1390470454-14272-1-git-send-email-bhe@redhat.com>
 <1390470454-14272-3-git-send-email-bhe@redhat.com>
 <52E5DA76.7070702@jp.fujitsu.com>
 <20140127085526.GB1481@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971E376F@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971E376F@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

 
> > > Removing this check changes behaviour, not just clean up, so should be separated into another patch.
> > > 
> > > Further, this change seems buggy because, in addition to Kumaga-san's comment, memory outside of
> > > cycle region can be passed to here. Please look at the below.
> > 
> > Hi Both,
> > 
> > I understand your finding. How about put the pfn checking back to
> > set_bitmap_cyclic(). Maybe this is simpler and safer. Otherwise each
> > case need be taken care and adding the pfn checking.
> 
> Agreed, and this simple check may have a small influence on the
> performance, so I think it's OK to do it.
> 

Sorry to responsed so late. Will post v3 to adding back the pfn checking
in set_bitmap_cyclic. 

Thanks for your suggestion.

Baoquan
Thanks



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
