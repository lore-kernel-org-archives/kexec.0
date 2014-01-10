Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1QXH-0005KN-D4
 for kexec@lists.infradead.org; Fri, 10 Jan 2014 01:05:20 +0000
Message-ID: <52CF4731.6090106@redhat.com>
Date: Thu, 09 Jan 2014 20:04:49 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] acpi memory hotplug, add parameter to disable memory
 hotplug for kexec
References: <1389220181-14474-1-git-send-email-prarit@redhat.com>
 <3476878.EqQiEtA2Ag@vostro.rjw.lan> <20140109150053.GD25897@redhat.com>
 <CAHGf_=oaPZNE8tVsZ1C1z3mHee8MK6CkuZ0YBTcJpRrTWgVn6g@mail.gmail.com>
 <20140109214425.GD12111@redhat.com>
In-Reply-To: <20140109214425.GD12111@redhat.com>
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
Cc: Kexec Mailing List <kexec@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, KOSAKI Motohiro <kosaki.motohiro@gmail.com>, Dave Young <dyoung@redhat.com>, Len Brown <lenb@kernel.org>



On 01/09/2014 04:44 PM, Vivek Goyal wrote:
> On Thu, Jan 09, 2014 at 04:34:16PM -0500, KOSAKI Motohiro wrote:
>> On Thu, Jan 9, 2014 at 10:00 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
>>> On Thu, Jan 09, 2014 at 12:00:29AM +0100, Rafael J. Wysocki wrote:

> 
> Makes sense. Something like "acpi_no_memhotplug" or "acpi_disable_memhotplug"
> or something else.
> 

FWIW ... after thinking about it and some of the other debug I've had to do,
maybe acpi=no_memhotplug and acpi=no_cpuhotplug are in order here.  I've had to
disable both during hardware enablement debug and it seems that it "fits" the
current acpi disabling scheme.

Unless, of course, Rafael still objects.

P.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
