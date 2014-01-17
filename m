Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3y28-00048V-05
 for kexec@lists.infradead.org; Fri, 17 Jan 2014 01:15:41 +0000
Message-ID: <52D8841F.9030709@redhat.com>
Date: Thu, 16 Jan 2014 20:15:11 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] acpi memory hotplug, add parameter to disable memory
 hotplug [v5]
References: <1389822660.1792.349.camel@misato.fc.hp.com>
 <1389886551-32647-1-git-send-email-prarit@redhat.com>
 <2048690.9OePJDLjDY@vostro.rjw.lan>
In-Reply-To: <2048690.9OePJDLjDY@vostro.rjw.lan>
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
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rientjes@google.com, kosaki.motohiro@gmail.com, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>, Len Brown <lenb@kernel.org>



On 01/16/2014 08:26 PM, Rafael J. Wysocki wrote:
> On Thursday, January 16, 2014 10:35:51 AM Prarit Bhargava wrote:
>> When booting a kdump kernel on a system that has specific memory hotplug
>> regions the boot will fail with warnings like:
> 
> The timestamps are still present, sigh.
> 
> OK, please see
> 
> http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=00159a2013269bc0a617de885e4b921349192bd0
> 
> and tell me if it looks good to you.
> 

Looks good to me.

P.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
