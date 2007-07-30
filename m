Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IFUhM-0002ch-Na
	for kexec@lists.infradead.org; Mon, 30 Jul 2007 08:50:26 -0400
Message-ID: <46ADDF9D.4060704@redhat.com>
Date: Mon, 30 Jul 2007 08:54:53 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: makedumpfile-1.1.5: Xen support
References: <46AA1AC0.2040702@redhat.com>
	<1181.219.4.192.46.1185620025.risu@secure.valinux.co.jp>
In-Reply-To: <1181.219.4.192.46.1185620025.risu@secure.valinux.co.jp>
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
To: Itsuro ODA <oda@valinux.co.jp>
Cc: kexec@lists.infradead.org

Itsuro ODA wrote:
> Hi Dave,
> 
> 
>>>Changelog:
>>>o Add a new feature that extracting the part of xen hypervisor and
>>>  domain-0 from /proc/vmcore. In most cases under xen environment,
>>>  it is enough to analyze a cause of system crash.
>>>  The patch was provided by Itsuro Oda.
>>>  Usage:
>>>    # makedumpfile -E --xen-syms xen-syms /proc/vmcore dumpfile
>>
>>Can you verify that the dumpfile created above is usable as both a
>>hypervisor dumpfile as well as a dom0 vmlinux dumpfile?  In other
>>words, can both of the following sessions be accomplished with the
>>resultant dumpfile?
>>
>>  # crash xen-syms dumpfile
>>
>>and:
>>
>>  # crash vmlinux dumpfile
>>
> 
> 
> Yes.
> 
> Thanks.

Great -- thanks.

Is the "-d" dump_level option completely ignored, or can it
(without vmlinux awareness) recognize and skip zero-filled
pages?

Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
