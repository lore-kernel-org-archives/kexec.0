Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8r9K-000325-9t
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 11:50:46 +0000
Message-ID: <51275B84.2030905@citrix.com>
Date: Fri, 22 Feb 2013 11:50:28 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 3/8] kexec: add public interface for improved
 load/unload sub-ops
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-4-git-send-email-david.vrabel@citrix.com>
 <51273B8502000078000C03BF@nat28.tlf.novell.com>
In-Reply-To: <51273B8502000078000C03BF@nat28.tlf.novell.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 22/02/13 08:33, Jan Beulich wrote:
>>>> On 21.02.13 at 18:48, David Vrabel <david.vrabel@citrix.com> wrote:
>> --- a/xen/include/public/kexec.h
>> +++ b/xen/include/public/kexec.h
>> @@ -116,12 +116,12 @@ typedef struct xen_kexec_exec {
>>   * type  == KEXEC_TYPE_DEFAULT or KEXEC_TYPE_CRASH [in]
>>   * image == relocation information for kexec (ignored for unload) [in]
>>   */
>> -#define KEXEC_CMD_kexec_load            1
>> -#define KEXEC_CMD_kexec_unload          2
>> -typedef struct xen_kexec_load {
>> +#define KEXEC_CMD_kexec_load_v1         1 /* obsolete since 0x00040300 */
>> +#define KEXEC_CMD_kexec_unload_v1       2 /* obsolete since 0x00040300 */
>> +typedef struct xen_kexec_load_v1 {
>>      int type;
>>      xen_kexec_image_t image;
>> -} xen_kexec_load_t;
>> +} xen_kexec_load_v1_t;
> 
> You can't change type names like this without also guarding them
> with a __XEN_INTERFACE_VERSION__ conditional or providing
> backward compatibility #define-s.

There are backward compatible definitions provided at the end of the
header file.

I will probably refactor this as it confused Daniel as well.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
