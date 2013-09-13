Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKSdS-0004SI-TI
 for kexec@lists.infradead.org; Fri, 13 Sep 2013 12:38:07 +0000
Message-ID: <52330714.8010907@citrix.com>
Date: Fri, 13 Sep 2013 13:37:40 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/9] kexec: add public interface for improved load/unload
 sub-ops
References: <1379015347-21653-1-git-send-email-david.vrabel@citrix.com>
 <1379015347-21653-3-git-send-email-david.vrabel@citrix.com>
 <5233048802000078000F3075@nat28.tlf.novell.com>
In-Reply-To: <5233048802000078000F3075@nat28.tlf.novell.com>
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
To: Jan Beulich <JBeulich@suse.com>
Cc: xen-devel <xen-devel@lists.xenproject.org>, Daniel Kiper <daniel.kiper@oracle.com>, Keir Fraser <keir@xen.org>, kexec@lists.infradead.org

On 13/09/13 11:26, Jan Beulich wrote:
>>>> On 12.09.13 at 21:49, David Vrabel <david.vrabel@citrix.com> wrote:
>> +#else /* __XEN_INTERFACE_VERSION__ < 0x00040400 */
>> +
>> +#define KEXEC_CMD_kexec_load KEXEC_CMD_kexec_load_v1
>> +#define KEXEC_CMD_kexec_unload KEXEC_CMD_kexec_unload_v1
>> +typedef struct xen_kexec_load {
>> +    int type;
>> +    xen_kexec_image_t image;
>> +} xen_kexec_load_t;
> 
> Is there anything preventing the use of two #define-s here
> instead of repeating the declaration (which results in these and
> the ones with the _v1 tags not being interchangeable)?

You mean:

#define xen_kexec_load xen_kexec_load_v1
#define xen_kexec_load_t xen_kexec_load_v1_t

I will do that.  I'm not sure I understand your concern about them not
being interchangeable though.  They do have identical layout.

David


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
