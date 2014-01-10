Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1dUx-0003AC-8A
 for kexec@lists.infradead.org; Fri, 10 Jan 2014 14:55:47 +0000
Message-ID: <52D009D7.1010600@redhat.com>
Date: Fri, 10 Jan 2014 09:55:19 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] acpi memory hotplug, add parameter to disable memory
 hotplug [v2]
References: <1389364615-13320-1-git-send-email-prarit@redhat.com>
 <20140110144910.GB19115@redhat.com>
In-Reply-To: <20140110144910.GB19115@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, kosaki.motohiro@gmail.com, dyoung@redhat.com, Len Brown <lenb@kernel.org>



On 01/10/2014 09:49 AM, Vivek Goyal wrote:
> On Fri, Jan 10, 2014 at 09:36:55AM -0500, Prarit Bhargava wrote:
> 
> [..]
>> This can also be reproduced by using the memmap=exactmap and mem=X
>> parameters on the main kernel and booting.
>>
>> This patchset resolves the problem by adding a kernel parameter,
>> acpi_no_memhotplug, to disable ACPI memory hotplug.
> 
> Hi Prarit,
> 
> People seem to like the idea of disabling hotplug automatically if
> memmap=exactmap or mem=X is passed on command line. Can you please take
> care of that too. That way we would not have to modify kexec-tools and
> kernel update will fix this issue.

Oh, okay.  I'll do that right now.

P.

> 
> Thanks
> Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
