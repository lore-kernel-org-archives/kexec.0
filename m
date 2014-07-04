Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X2zXU-00033v-GE
 for kexec@lists.infradead.org; Fri, 04 Jul 2014 09:12:17 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2] makedumpfile: Exclude unnecessary hugepages.
Date: Fri, 4 Jul 2014 09:09:30 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9723D694@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9722301C@BPXM01GP.gisp.nec.co.jp>
 <20140702082654.GB20309@dhcp-16-105.nay.redhat.com>
 <20140702104116.6c870b37@hananiah.suse.cz>
 <20140702085136.GC20309@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20140702085136.GC20309@dhcp-16-105.nay.redhat.com>
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
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "ptesarik@suse.cz" <ptesarik@suse.cz>

>On 07/02/14 at 10:41am, Petr Tesarik wrote:
>> On Wed, 2 Jul 2014 16:26:54 +0800
>> Baoquan He <bhe@redhat.com> wrote:
>>
>> > On 06/17/14 at 02:32am, Atsushi Kumagai wrote:
>> >
>> > > +static void
>> > > +setup_page_is_hugepage(void)
>> > > +{
>> > > +	if (NUMBER(PG_head) != NOT_FOUND_NUMBER) {
>> > > +		if (NUMBER(PG_tail) == NOT_FOUND_NUMBER) {
>> > > +			/*
>> > > +			 * If PG_tail is not explicitly saved, then assume
>> > > +			 * that it immediately follows PG_head.
>> > > +			 */
>> > > +			NUMBER(PG_tail) = NUMBER(PG_head) + 1;
>> > > +		}
>> > > +	} else if ((NUMBER(PG_compound) != NOT_FOUND_NUMBER)
>> > > +		   && (info->dump_level & DL_EXCLUDE_USER_DATA)) {
>> >
>> > Hi,
>> >
>> > I may not understand hugepage well. I am wondering why hugepage
>> > filtering can't be done if PG_compound is available.
>>
>> Oh, maybe I'm missing something. What do you suggest as an alternative
>> way to recognize a huge page if the value of PG_compound is not known?
>
>No, what I understood is PG_compound is known if
>(NUMBER(PG_compound) != NOT_FOUND_NUMBER).
>
>I am not sure about this.

It's just my mistake, sorry!

BTW, I'm testing the v3 patch based on the Petr's comment, sorry for
keeping you waiting for it.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
