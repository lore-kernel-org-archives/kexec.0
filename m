Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VoGJu-0003M0-1i
 for kexec@lists.infradead.org; Wed, 04 Dec 2013 17:33:07 +0000
Date: Wed, 4 Dec 2013 12:32:39 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20131204173238.GD19087@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-5-git-send-email-vgoyal@redhat.com>
 <20131204015657.GD3298@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131204015657.GD3298@localhost.localdomain>
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
To: Baoquan He <bhe@redhat.com>
Cc: mjg59@srcf.ucam.org, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On Wed, Dec 04, 2013 at 09:56:57AM +0800, Baoquan He wrote:
> On 11/20/13 at 12:50pm, Vivek Goyal wrote:
> > + * that kexec_mutex is held.
> > + */
> 
> I think kexec_add_buffer is guaranteed to be called before allocating
> control pages, why not updating image->control_page after each time
> kexec_add_buffer is called. Then when control page is needed, effective
> address in crash_kernel region can be given. This can be a little more
> efficient.

image->control_page controls the lowest address available for control
pages in crash kernel region. When we do kexec_add_buffer, we don't
necessarily know whether there is an empty page available between
segments or not.

Also, existing logic for kexec does not update the image->control_page
when segments are being copied.

So I think this does not offer any huge benefits and it is not performance
critical path. I will just leave it as it is.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
