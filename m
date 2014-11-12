Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XoZG8-00011b-BU
 for kexec@lists.infradead.org; Wed, 12 Nov 2014 14:51:01 +0000
Message-ID: <546373B8.70103@redhat.com>
Date: Wed, 12 Nov 2014 15:50:32 +0100
From: Laszlo Ersek <lersek@redhat.com>
MIME-Version: 1.0
Subject: Re: uniquely identifying KDUMP files that originate from QEMU
References: <5461F18C.2080400@redhat.com>	<20141111130913.11eec0a3@hananiah.suse.cz>	<20141112.120838.303682123986142686.d.hatayama@jp.fujitsu.com>
 <20141112090441.3ee42632@hananiah.suse.cz>
In-Reply-To: <20141112090441.3ee42632@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org

On 11/12/14 09:04, Petr Tesarik wrote:
> On Wed, 12 Nov 2014 12:08:38 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

>> Anyway, phys_base is kernel information. To make it available for qemu
>> side, there's need to prepare a mechanism for qemu to have any access
>> to it.
> 
> Yes. I wonder if you can have access without some sort of co-operation
> from the guest kernel itself. I guess not.

Propagating any kind of additional information from the guest kernel
(which is unprivileged and potentially malicious) to the host-side qemu
process (which is by definition more privileged, although still confined
by various measures) is something we'd explicitly like to avoid.

Think of it like this. I throw a physical box at you, running Linux,
that has frozen in time. Can "crash" work with nothing else but the
contents of the memory, and information about the CPUs? It certainly
can, it already does. It might need more heuristics than in when the
guest kernel offers those bits of info on a plate, but those heuristics
already work. We just need to tell "crash" that this particular box,
flying in the air, has been launched by qemu, so that "crash" enable its
heuristics.

Thanks
Laszlo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
