Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.lang.hm ([64.81.33.126] helo=bifrost.lang.hm)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZEVk-0004uy-Mc
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 00:08:01 +0000
Date: Tue, 11 Mar 2008 17:09:32 -0700 (PDT)
From: david@lang.hm
Subject: Re: [PATCH -mm] kexec jump -v9
In-Reply-To: <1205272758.7990.37.camel@nigel-laptop>
Message-ID: <alpine.DEB.1.00.0803111708270.32330@asgard.lang.hm>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>
	<1205272758.7990.37.camel@nigel-laptop>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Wed, 12 Mar 2008, Nigel Cunningham wrote:

> 3. Usability.
>
> Right now, kexec based hibernation looks quite complicated to configure,
> and the user is apparently going to have to remember to boot a different
> kernel or at least a different bootloader entry in order to resume. Not
> a plus. It would be good if you could find a way to use one bootloader
> entry, resuming if there's an image, booting normally if there's not.

I don't see any reason why this couldn't be done with an initrd to decide 
if you are doing a normal boot or a restore.

David Lang

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
