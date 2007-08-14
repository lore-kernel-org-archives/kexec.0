Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IKrru-0001aV-E9
	for kexec@lists.infradead.org; Tue, 14 Aug 2007 04:35:18 -0400
Message-ID: <46C1691E.7090708@ah.jp.nec.com>
Date: Tue, 14 Aug 2007 17:34:38 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [patch] add kdump_after_notifier
References: <20070802112852.GA7054@in.ibm.com>
	<31687.1186113947@kao2.melbourne.sgi.com>
	<20070805110746.GA12540@in.ibm.com>
In-Reply-To: <20070805110746.GA12540@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: Keith Owens <kaos@sgi.com>, k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>

Vivek Goyal wrote:
> On Fri, Aug 03, 2007 at 02:05:47PM +1000, Keith Owens wrote:
> 
> 
> To sum up, couple of options come to mind.
> 
> - Register all the RAS tools on die notifier and panic
>   notifier lists with fairly high priority. Export list
>   of RAS tools to user space and allow users to decide the
>   order of execution and priority of RAS tools.
> 
> - Create a separate RAS tool notifier list (ras_tool_notifer_list).
>   All the RAS tools register on this list. This list gets priority
>   over die or panic notifier list. User decides the oder of execution
>   of RAS tools. 
> 
>   Here assumption is that above list will not be exported to modules.
>   All the RAS tools will be in kernel and they always get a priority
>   to inspect an event.
> 
> What do others think?

Very good idea. But there is a problem how to give default priority to RAS tools.

How about priority changeable notifier_list? User can change list order
dynamically if they want. Of course, we have to give highest priority to kdump
by default. It is very useful for users who want to use some RAS tools.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
