Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IEjvi-00036x-AF
	for kexec@lists.infradead.org; Sat, 28 Jul 2007 06:53:52 -0400
Message-ID: <1181.219.4.192.46.1185620025.risu@secure.valinux.co.jp>
In-Reply-To: <46AA1AC0.2040702@redhat.com>
References: <46AA1AC0.2040702@redhat.com>
Date: Sat, 28 Jul 2007 19:53:45 +0900 (JST)
Subject: Re: makedumpfile-1.1.5: Xen support
From: "Itsuro ODA" <oda@valinux.co.jp>
MIME-Version: 1.0
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
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org

Hi Dave,

>> Changelog:
>> o Add a new feature that extracting the part of xen hypervisor and
>>   domain-0 from /proc/vmcore. In most cases under xen environment,
>>   it is enough to analyze a cause of system crash.
>>   The patch was provided by Itsuro Oda.
>>   Usage:
>>     # makedumpfile -E --xen-syms xen-syms /proc/vmcore dumpfile
>
> Can you verify that the dumpfile created above is usable as both a
> hypervisor dumpfile as well as a dom0 vmlinux dumpfile?  In other
> words, can both of the following sessions be accomplished with the
> resultant dumpfile?
>
>   # crash xen-syms dumpfile
>
> and:
>
>   # crash vmlinux dumpfile
>

Yes.

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
