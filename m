Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKQam-0000bA-JN
 for kexec@lists.infradead.org; Fri, 13 Sep 2013 10:27:13 +0000
Message-Id: <5233048802000078000F3075@nat28.tlf.novell.com>
Date: Fri, 13 Sep 2013 11:26:48 +0100
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH 2/9] kexec: add public interface for improved
 load/unload sub-ops
References: <1379015347-21653-1-git-send-email-david.vrabel@citrix.com>
 <1379015347-21653-3-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1379015347-21653-3-git-send-email-david.vrabel@citrix.com>
Mime-Version: 1.0
Content-Disposition: inline
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: xen-devel <xen-devel@lists.xenproject.org>, Daniel Kiper <daniel.kiper@oracle.com>, Keir Fraser <keir@xen.org>, kexec@lists.infradead.org

>>> On 12.09.13 at 21:49, David Vrabel <david.vrabel@citrix.com> wrote:
> +#else /* __XEN_INTERFACE_VERSION__ < 0x00040400 */
> +
> +#define KEXEC_CMD_kexec_load KEXEC_CMD_kexec_load_v1
> +#define KEXEC_CMD_kexec_unload KEXEC_CMD_kexec_unload_v1
> +typedef struct xen_kexec_load {
> +    int type;
> +    xen_kexec_image_t image;
> +} xen_kexec_load_t;

Is there anything preventing the use of two #define-s here
instead of repeating the declaration (which results in these and
the ones with the _v1 tags not being interchangeable)?

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
