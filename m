Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pz0-f49.google.com ([209.85.210.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S7Hwq-0007ra-9M
 for kexec@lists.infradead.org; Tue, 13 Mar 2012 02:58:52 +0000
Received: by dakp5 with SMTP id p5so145310dak.36
 for <kexec@lists.infradead.org>; Mon, 12 Mar 2012 19:58:47 -0700 (PDT)
Message-ID: <4F5EB7E0.8040701@gmail.com>
Date: Tue, 13 Mar 2012 10:58:40 +0800
From: Cong Wang <xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] Add generic debug option
References: <1331188782-10912-1-git-send-email-xiyou.wangcong@gmail.com>
 <20120313002116.GB24671@verge.net.au>
In-Reply-To: <20120313002116.GB24671@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On 03/13/2012 08:21 AM, Simon Horman wrote:
> On Thu, Mar 08, 2012 at 02:39:38PM +0800, Cong Wang wrote:
>> Currently the debugging code is under #ifdef DEBUG, which
>> means when we want to debug, we have to re-compile the source
>> code with -DDEBUG. This is not convenient, we want to have
>> a generic --debug option so that we can enable debugging code
>> without re-compiling.
>>
>> This patch moves the arch-specific --debug to generic place
>> and moves code under #ifdef DEBUG to --debug on x86.
>>
>> BTW, the size of kexec binary increases very little after this patch.
>
> Hi Cong,
>
> In general I am happy with making kexec easier to use.  However, it would
> be nice not to make kexec-tools even bigger than it already is. Its size
> already seems to be an issue for some people on ARM at least.  Do you
> have some feeling for the change in binary size on architectures other than
> i386?
>

Hi,

I only tested the patches on x86 and ppc.

Sorry I don't have a chance to test it on ARM, on ARM it just adds a 
small function dump_memory_ranges(), if this would be a problem, feel 
free to drop patch 3/5. :)

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
