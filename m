Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QPJF8-0005hQ-OX
	for kexec@lists.infradead.org; Wed, 25 May 2011 18:55:43 +0000
Date: Wed, 25 May 2011 14:55:24 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/8] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
Message-ID: <20110525185524.GA6724@redhat.com>
References: <20110517195751.12740.97565.stgit@mars.in.ibm.com>
	<20110524203542.GH3860@redhat.com>
	<20110525074407.GA9525@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110525074407.GA9525@in.ibm.com>
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
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, V Srivatsa <vatsa@linux.vnet.ibm.com>, Tachibana <tachibana@mxm.nes.nec.co.jp>, Dave Anderson <anderson@redhat.com>, Reinhard <BUENDGEN@de.ibm.com>

On Wed, May 25, 2011 at 01:14:07PM +0530, Mahesh J Salgaonkar wrote:
> On 2011-05-24 16:35:42 Tue, Vivek Goyal wrote:
> > On Wed, May 18, 2011 at 01:29:06AM +0530, Mahesh J Salgaonkar wrote:
> > > Hi All,
> > > 
> > > Please find the version 2 of makedumpfile enhancement patchset that introduces
> > > a data filtering feature which enables makedumpfile to filter out desired kernel
> > > symbol data and it's members from the specified VMCORE file. The data to be
> > > filtered out is poisoned with character 'X' (58 in Hex).
> > > 
> > > This feature will be very useful for the customers who wants to erase the
> > > customer sensitive data like security keys and other confidential data, in
> > > DUMPFILE before sending it to support team for analysis.
> > 
> > Mahesh,
> > 
> > Apart from security keys, what are the other examples of data which needs
> > to be removed?
> 
> The idea is to allow customer to remove any such confidential data that
> he thinks should not be disclosed outside. The framework is generic
> enough to accommodate any new such fields.

So what is that info which customer whould like to erase (apart from
security keys?) Do we have some more concrete examples?

> The is intended just as a
> security filter and not to be used as detrimental to crash's analysis of the
> dump.

How would we know in advance that what symbols crash is dependent on
to even open crash dump and we are not erasing one of those symbols. In
other mail Dave mentioned two symbols (vmlist and one more) which crash
is dependent on and we seem to be clearing that.

I am worried about filtering out symbols which make crash non functional.
Dave mentioned that one can remove the pointer which contains the list
of modules etc. I am worried what if module caused the crash and we break
the chain in such a way that reaching to module data structures is not
possible anymore.

If security key is only example, should we just hardcode that in makedumpfile
to wipe that info instead of creating a generic framework for this. If we
give user too much flexibility they might delete way too many symbols to
be safe and that might result in un-analyzable crash dump.

> 
> > 
> > By erasing the data, you mean you set it to zero? Will it make sense to
> > poison it with some specific pattern so that if crash or other tool
> > are looking into it they know it has been posioned and it is not a
> > case of corruption. This might help if a user erased a symbol which was
> > required by crash for some analysis etc.
> 
> The data to be erased is poisoned with character 'X' (58 in Hex).
> 
> The last two patches 7/8 and 8/8 introduces eraseinfo section into
> filtered compressed kdump and ELF kdump file. The compressed kdump file
> now carries additional fields namely offset_eraseinfo and size_eraseinfo in
> kdump sub header that can help crash to identify whether filtering is
> been done. Similarly, ELF kdump file now contains new ELF note of type
> NT_ERASEINFO, that can help crash to identify whether the filtering has been
> done or not.

And how this information is useful to crash? I mean why would crash care
whether filtering has been done or not and if filtering has been done
then do what?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
