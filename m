Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gw0-f49.google.com ([74.125.83.49])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Ogr2f-0002XG-EX
	for kexec@lists.infradead.org; Thu, 05 Aug 2010 03:22:49 +0000
Received: by gwb10 with SMTP id 10so2793808gwb.36
	for <kexec@lists.infradead.org>; Wed, 04 Aug 2010 20:22:48 -0700 (PDT)
Date: Thu, 5 Aug 2010 11:26:58 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [rfc] Merge kexec-tools into the kernel tree
Message-ID: <20100805032658.GB5235@cr0.nay.redhat.com>
References: <20100804070647.GB24064@verge.net.au>
	<m17hk6de62.fsf@fess.ebiederm.org> <30114.1280963486@neuling.org>
	<m1vd7q0vsx.fsf@fess.ebiederm.org> <5789.1280971186@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5789.1280971186@neuling.org>
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
To: Michael Neuling <mikey@neuling.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On Thu, Aug 05, 2010 at 11:19:46AM +1000, Michael Neuling wrote:
>> If we talk about analyzing and filtering crash dumps, I can totally
>> see an argument for putting something under tools/ if the authors of
>> mkdumpfile and crash are interested.  Those tools fundamentally really
>> do follow kernel internals.
>
>I agree that the argument is stronger for tools/ inclusion if internal
>APIs need to be followed.  Of course perf doesn't need internals APIs
>and it's in tools/.
>

Well, I don't remember clearly why perf was proposed to be included into
kernel tree by Ingo, I think it was internal API/ABI issue as well.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
