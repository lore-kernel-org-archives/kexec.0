Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hfrsq-0000j1-6x
	for kexec@lists.infradead.org; Mon, 23 Apr 2007 02:18:48 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 2/2] x86_64: Remove CONFIG_PHYSICAL_START and
	CONFIG_RELOCATABLE
References: <20070331232957.e1c93f19.akpm@linux-foundation.org>
	<20070402074159.GA13704@in.ibm.com>
	<m1abxrf9o3.fsf@ebiederm.dsl.xmission.com>
	<20070402094520.GC13704@in.ibm.com>
	<m1648eg01d.fsf@ebiederm.dsl.xmission.com>
	<20070403040152.GA5108@in.ibm.com>
	<m1zm5qc9q2.fsf@ebiederm.dsl.xmission.com>
	<20070403100349.GA21759@in.ibm.com>
	<m18xcjznbm.fsf_-_@ebiederm.dsl.xmission.com>
	<m14pn7zn5n.fsf_-_@ebiederm.dsl.xmission.com>
	<20070423060739.GA14664@in.ibm.com>
Date: Mon, 23 Apr 2007 00:17:22 -0600
In-Reply-To: <20070423060739.GA14664@in.ibm.com> (Vivek Goyal's message of
	"Mon, 23 Apr 2007 11:37:39 +0530")
Message-ID: <m1slary5ql.fsf@ebiederm.dsl.xmission.com>
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
To: vgoyal@in.ibm.com
Cc: fastboot@osdl.org, Kexec Mailing List <kexec@lists.infradead.org>, Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org, Magnus Damm <magnus@valinux.co.jp>, Helge Hafting <helgehaf@aitel.hist.no>, Horms <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Sun, Apr 22, 2007 at 11:15:48PM -0600, Eric W. Biederman wrote:
>> +++ b/arch/x86_64/Kconfig
>> @@ -565,62 +565,9 @@ config CRASH_DUMP
>>            which are loaded in the main kernel with kexec-tools into
>>            a specially reserved region and then later executed after
>>            a crash by kdump/kexec. The crash dump kernel must be compiled
>> -	  to a memory address not used by the main kernel or BIOS using
>> -	  PHYSICAL_START.
>> +	  to a memory address not used by the main kernel or BIOS
>>            For more details see Documentation/kdump/kdump.txt
>
> Hi Eric,
>
> I think "must be compiled" should be replaced with "must be loaded" now.

Yes, that sounds right.  Ugh.  I didn't look at enough context to read
the whole sentence.  I just killed the part about PHYSICAL_START.

> Otherwise both the patches look fine.  I am planning to test these.
>
> This change will also require modifications to Documentation/kdump/kdump.txt
> file.

Do you think you can generate the patch fix up the CONFIG_CRASH_DUMP
and kdump.txt documentation.

I was just interested enough to spend the 15 minutes needed to generate
this patch.  I don't think I care enough to dot the i's and cross the t's
in the documentation.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
