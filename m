Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3TVr-0004uU-8c
 for kexec@lists.infradead.org; Wed, 15 Jan 2014 16:40:20 +0000
Date: Wed, 15 Jan 2014 11:39:53 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] acpi memory hotplug, add parameter to disable memory
 hotplug [v4]
Message-ID: <20140115163953.GB3180@redhat.com>
References: <alpine.DEB.2.02.1401141642020.3375@chino.kir.corp.google.com>
 <1389789284-10622-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389789284-10622-1-git-send-email-prarit@redhat.com>
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
To: Prarit Bhargava <prarit@redhat.com>
Cc: kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, kosaki.motohiro@gmail.com, dyoung@redhat.com, Len Brown <lenb@kernel.org>

On Wed, Jan 15, 2014 at 07:34:44AM -0500, Prarit Bhargava wrote:

[..]
> This patchset resolves the problem by adding a kernel parameter,
> acpi_no_memhotplug, to disable ACPI memory hotplug.
> 
> [v2]: changed acpi_no_memhotplug to bool
> [v3]: cleaned up Documentation/kernel-parameters.txt
> [v4]: add __initdata to acpi_no_memhotplug
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: kosaki.motohiro@gmail.com
> Cc: dyoung@redhat.com
> Cc: linux-acpi@vger.kernel.org
> Cc: kexec@lists.infradead.org

Hi Prarit,

Capture all the acks from V3 here so that people don't have to ack 
again. This is a minor change as compared to V3. 

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
