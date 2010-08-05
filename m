Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pz0-f49.google.com ([209.85.210.49])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OgqyB-0003ZE-SJ
	for kexec@lists.infradead.org; Thu, 05 Aug 2010 03:18:12 +0000
Received: by pzk3 with SMTP id 3so2664050pzk.36
	for <kexec@lists.infradead.org>; Wed, 04 Aug 2010 20:18:10 -0700 (PDT)
Date: Thu, 5 Aug 2010 11:22:17 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [rfc] Merge kexec-tools into the kernel tree
Message-ID: <20100805032217.GA5235@cr0.nay.redhat.com>
References: <20100804070647.GB24064@verge.net.au>
	<m17hk6de62.fsf@fess.ebiederm.org> <30114.1280963486@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30114.1280963486@neuling.org>
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

On Thu, Aug 05, 2010 at 09:11:26AM +1000, Michael Neuling wrote:
>> > After all the excitement of relocating kexec-tools from
>> > one location on kernel.org to another last week it was
>> > suggested to me by Michael Neuling that the merging
>> > kexec-tools into the kernel tree would be a good idea.
>> >
>> > Given that there have been a bunch of issues with kexec
>> > on power that this would resolve. and there is precedence
>> > for tools in the kernel tree, this sounds entirely reasonable to me.
>> > So with my kexec-tools maintainer hat on, I would like to start
>> > a conversation about this.
>> 
>> What are the issues with kexec on power?  Did someone fail to maintain
>> ABI compatibility?
>> 
>> The interface isn't even supposed to be linux specific, so I can't
>> imagine what would motivate moving this into the kernel tree.
>> 
>> I'm afraid that someone has a good answer for why their lives would be
>> simpler if /sbin/kexec was in the kernel tree and I will be absolutely
>> horrified and about someones stupidity when I hear that answer.
>
>I may have misrepresented how bad it is for power to Horms.  None of the
>issues would be solved by a merge, but it would make life easier IMHO.
>
>In power we've added features to kexec which have required changes to
>both the kernel and kexec-tools.  These have been backwards compatible,
>so not to break to the ABI.  The problem here is getting users and
>distros to take the correct versions of both sources if they want this
>new feature.
>
>Similarly with bugs.  We recently went through a round of bug fixes for
>new larger power7 machines.  We found bugs in both kexec-tools and the
>kernel.  That meant we had to ensure users and distros were getting
>correctly updated versions of both tools.


I am afraid kexec-tools is not alone, there are plenty of user-space
applications which rely on some new kernel feature after a specific version.
If this could be a reason for inclusion into kernel tree, then much more
applications shall be included too. And if this happened, Linux would be
more like *BSD.

Also, this is a big reason why linux distributions exist. They are
responsible for collecting the right version of some application and the
right version of kernel that makes them work together.

So, I think  _we_ should get used to this unless Linus decides to change
this model.

>Neither of these problems are show stoppers or power specific but I
>think it would make life easier in these scenarios if the sources were
>merged.  We could just tell users and distros to grab (say) 2.6.35
>sources and we'd know they'd be right for both userspace and the kernel.
>

I think the solution is documention, or release notes, not including
it into kernel tree.

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
