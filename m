Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ILbdd-0005LS-8M
	for kexec@lists.infradead.org; Thu, 16 Aug 2007 05:27:36 -0400
Message-ID: <46C4184B.5030303@ah.jp.nec.com>
Date: Thu, 16 Aug 2007 18:26:35 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [patch] add kdump_after_notifier
References: <20070802112852.GA7054@in.ibm.com>
	<31687.1186113947@kao2.melbourne.sgi.com>
	<20070805110746.GA12540@in.ibm.com>
	<46C1691E.7090708@ah.jp.nec.com> <20070814083710.GA14538@suse.de>
	<20070814132454.GA8293@in.ibm.com>
In-Reply-To: <20070814132454.GA8293@in.ibm.com>
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
Cc: k-miyoshi@cb.jp.nec.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Vivek Goyal wrote:
 > So for the time being I think we can put RAS tools on die notifier list
> and if it runs into issues we can always think of creating a separate list.
> 
> Few things come to mind.
> 
> - Why there is a separate panic_notifier_list? Can't it be merged with
>   die_chain? die_val already got one of the event type as PANIC. If there
>   are no specific reasons then we should merge the two lists. Registering
>   RAS tools on a single list is easier.

I think it is difficult, because die_chain is defined by each architecture.

> - Modify Kdump to register on die_chain list. 
> - Modify Kdb to register on die_chain list.
> - Export all the registered members of die_chain through sysfs along with
>   their priorities. Priorities should be modifiable. Most likely one 
>   shall have to introduce additional field in struct notifier_block. This
>   field will be a string as an identifier of the user registerd. e.g
>   "Kdump", "Kdb" etc.
> 
> Now user will be able to view all the die_chain users through sysfs and
> be able to modify the order in which these should run by modifying their
> priority. Hence all the RAS tools can co-exist.

This is my image of your proposal.

- Print current order

# cat /sys/class/misc/debug/panic_notifier_list
priority   name
1          IPMI
2          watchdog
3          Kdb
4          Kdump

- change list order

# echo <before> <after> > /sys/class/debug/panic_notifier_list

- example

# cat /sys/class/misc/debug/panic_notifier_list
priority   name
1          IPMI
2          watchdog
3          Kdb
4          Kdump

# echo 4 1 > /sys/class/debug/panic_notifier_list
priority   name
1          Kdump
2          IPMI
3          watchdog
4          Kdb


Is my image almost same as your thought?

Thanks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
