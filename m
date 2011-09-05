Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R0aLy-0004Xi-D9
	for kexec@lists.infradead.org; Mon, 05 Sep 2011 14:40:52 +0000
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
	Mon, 5 Sep 2011 15:37:20 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p85Ed3JV1331240
	for <kexec@lists.infradead.org>; Tue, 6 Sep 2011 00:39:03 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p85EebhU012727
	for <kexec@lists.infradead.org>; Tue, 6 Sep 2011 00:40:37 +1000
Date: Mon, 5 Sep 2011 20:10:33 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 6/8] makedumpfile: Read and process 'for' command
	from config file.
Message-ID: <20110905144033.GA26767@in.ibm.com>
References: <20110517200514.12740.86690.stgit@mars.in.ibm.com>
	<20110811170621.2f931dbe.oomichi@mxs.nes.nec.co.jp>
	<20110830181642.GA21808@in.ibm.com>
	<20110901170658.67f830df.oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110901170658.67f830df.oomichi@mxs.nes.nec.co.jp>
Reply-To: mahesh@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi Ken'ichi,

On 2011-09-01 17:06:58 Thu, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> Thank you for the patch.
> I have one question.
> 
> On Tue, 30 Aug 2011 23:46:42 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > 
> > [PATCH] makedumpfile: Fix array traversal for array of structure and char type.
> > 
> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > 
> > Introduce new function get_next_list_entry() that returns config entry
> > for each element in the LIST entry. This approach improves the handling
> > of LIST entry. With this change the function get_config_symbol_addr()
> > no longer required to handle LIST entry separately.
> > 
> > This patch fixes following BUGs:
> 
> [..]
> 
> > - The loop construct used for array of char* (pointer) silently fails and
> > does not filter the strings.
> 
> Did the silent failure happen at the following code of list_entry_empty() ?
> 
>    7373         addr = get_config_symbol_addr(le, 0, NULL);
>    7374         if (!addr)
>    7375                 return TRUE;
> 

Nope. It use to fail in resolve_list_entry()->resolve_config_entry()
and following hunk from the patch fixes it:

@@ -6866,7 +6882,7 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_addr,
 		 * If this is a struct or list_head data type then
 		 * create a leaf node entry with 'next' member.
 		 */
-		if ((ce->type_flag & TYPE_BASE)
+		if (((ce->type_flag & (TYPE_BASE | TYPE_ARRAY)) == TYPE_BASE)
 					&& (strcmp(ce->type_name, "void")))
 			return FALSE;
 
The old code use to check only TYPE_BASE flag ignoring TYPE_ARRAY flag.

> If list_entry_empty() returns TRUE, a "while" loop of process_config() breaks
> and update_filter_info() is not called.
> Is that the problem you said ?
> 
> If yes, I feel the behavior related with this problem has not changed.
> because the method for getting a pointer array has not changed like the
> following:

The while loop below still holds good as it just ignores the pointer array
elements which are NULL pointers and we dont have anything to be erased for
NULL pointers.

> 
> o OLD
>     111 -                               while (ce->index < ce->array_length) {
>     112 -                                       addr = read_pointer_value(ce->addr +
>     113 -                                               (ce->index * get_pointer_size()));
>     114 -                                       ce->index++;
>     115 -                                       if (addr)
>     116 -                                               break;
>     117 -                               }
>     118 -                               return addr;
> 
> o NEW
>     197 +                               while (ce->index < ce->array_length) {
>     198 +                                       addr = read_pointer_value(ce->addr +
>     199 +                                               (ce->index * get_pointer_size()));
>     200 +                                       if (addr)
>     201 +                                               break;
>     202 +                                       ce->index++;
>     203 +                               }
>     204 +                               if (ce->index == ce->array_length)
>     205 +                                       return FALSE;
> 
> 
> I think the other bugfixes are right, thanks.
> 
> 
> Thanks
> Ken'ichi Ohmichi
> 

Thanks,
-Mahesh.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
